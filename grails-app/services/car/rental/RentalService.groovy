package car.rental

import grails.gorm.transactions.Transactional

@Transactional
class RentalService {

    PricingService pricingService


    /**
     * Returns a rental by id.
     */
    Rental get(Long id) {
        Rental.get(id)
    }


    /**
     * Returns all rentals.
     * Used by the admin.
     */
    def listAll(Map params = [:]) {

        Rental.createCriteria().list(params) {
            order('id', 'desc')
        }
    }



    /**
     * Returns rentals relevant to the admin operational page.
     *
     * PENDING rentals are intentionally hidden because the customer
     * has not confirmed the reservation by paying the booking deposit yet.
     *
     * CANCELLED rentals are also excluded from the operational list.
     */
    def listForAdmin(
            Map params = [:]) {

        Rental.createCriteria().list(params) {

            inList(
                    'status',
                    [
                            'CONFIRMED',
                            'PICKED_UP',
                            'COMPLETED'
                    ]
            )

            order('id', 'desc')
        }
    }


    /**
     * Returns rentals belonging to one customer only.
     */
    def listForCustomer(
            User customer,
            Map params = [:]) {

        Rental.createCriteria().list(params) {

            eq('customer', customer)

            order('id', 'desc')
        }
    }



    /**
     * Returns only active rentals for a customer.
     *
     * My Rentals:
     * PENDING / CONFIRMED / PICKED_UP
     */
    def listActiveForCustomer(
            User customer,
            Map params = [:]) {

        Rental.createCriteria().list(params) {

            eq('customer', customer)

            inList(
                    'status',
                    [
                            'PENDING',
                            'CONFIRMED',
                            'PICKED_UP'
                    ]
            )

            order('id', 'desc')
        }
    }


    /**
     * Returns finished rentals for a customer.
     *
     * Rental History:
     * COMPLETED / CANCELLED
     */
    def listHistoryForCustomer(
            User customer,
            Map params = [:]) {

        Rental.createCriteria().list(params) {

            eq('customer', customer)

            inList(
                    'status',
                    [
                            'COMPLETED',
                            'CANCELLED'
                    ]
            )

            order('id', 'desc')
        }
    }


    /**
     * Returns ids of CONFIRMED rentals whose pickup/start date is today.
     *
     * These are the cars the admin should hand over today.
     */
    Set<Long> getPickupDueTodayIds() {

        java.time.ZoneId zone =
                java.time.ZoneId.systemDefault()


        java.time.LocalDate today =
                java.time.LocalDate.now(zone)


        Date startOfToday =
                Date.from(
                        today
                                .atStartOfDay(zone)
                                .toInstant()
                )


        Date startOfTomorrow =
                Date.from(
                        today
                                .plusDays(1)
                                .atStartOfDay(zone)
                                .toInstant()
                )


        def ids =
                Rental.createCriteria().list {

                    eq(
                            'status',
                            'CONFIRMED'
                    )


                    ge(
                            'startDate',
                            startOfToday
                    )


                    lt(
                            'startDate',
                            startOfTomorrow
                    )


                    projections {
                        property('id')
                    }
                }


        ids as Set<Long>
    }


    /**
     * Returns ids of PICKED_UP rentals whose return date is today.
     *
     * Date comparison is done in the service instead of the GSP
     * so the view does not call Date.format()/new Date().
     */
    Set<Long> getReturnDueTodayIds() {

        java.time.ZoneId zone =
                java.time.ZoneId.systemDefault()


        java.time.LocalDate today =
                java.time.LocalDate.now(zone)


        Date startOfToday =
                Date.from(
                        today
                                .atStartOfDay(zone)
                                .toInstant()
                )


        Date startOfTomorrow =
                Date.from(
                        today
                                .plusDays(1)
                                .atStartOfDay(zone)
                                .toInstant()
                )


        def ids =
                Rental.createCriteria().list {

                    eq(
                            'status',
                            'PICKED_UP'
                    )


                    ge(
                            'endDate',
                            startOfToday
                    )


                    lt(
                            'endDate',
                            startOfTomorrow
                    )


                    projections {
                        property('id')
                    }
                }


        ids as Set<Long>
    }


    /**
     * Returns bookings that actually block
     * this car from being booked.
     *
     * PENDING rentals are intentionally excluded
     * because the reservation is not confirmed
     * until the booking deposit is paid.
     */
    List<Rental> getActiveBookingsForCar(Car car) {

        if (!car) {
            return []
        }


        Rental.findAllByCarAndStatusInList(
                car,
                [
                        'CONFIRMED',
                        'PICKED_UP'
                ],
                [
                        sort : 'startDate',
                        order: 'asc'
                ]
        )
    }


    /**
     * Creates a new rental request.
     *
     * The rental starts as PENDING and does not
     * become a confirmed reservation until the
     * booking deposit is paid.
     */
    Rental createRental(
            User customer,
            Long carId,
            Date startDate,
            Date endDate) {


        // Customer is required
        if (!customer) {

            throw new IllegalArgumentException(
                    'Customer is required.'
            )
        }


        // Find car
        Car car =
                Car.get(carId)


        if (!car) {

            throw new IllegalArgumentException(
                    'Car not found.'
            )
        }


        // Dates are required
        if (!startDate || !endDate) {

            throw new IllegalArgumentException(
                    'Start date and end date are required.'
            )
        }


        // Today's date
        Date today =
                java.sql.Date.valueOf(
                        java.time.LocalDate.now()
                )


        // Cannot rent in the past
        if (startDate.before(today)) {

            throw new IllegalArgumentException(
                    'Start date cannot be in the past.'
            )
        }


        // End cannot be before start
        if (endDate.before(startDate)) {

            throw new IllegalArgumentException(
                    'End date cannot be before start date.'
            )
        }


        // Maintenance cars cannot be rented
        if (car.status == 'MAINTENANCE') {

            throw new IllegalStateException(
                    'This car is currently under maintenance.'
            )
        }


        /*
         * Check only CONFIRMED / PICKED_UP rentals.
         *
         * PENDING does NOT block the car.
         *
         * Example:
         *
         * Confirmed:
         * 10 Aug -------- 15 Aug
         *
         * Requested:
         *       12 Aug -------- 18 Aug
         *
         * = overlap
         */
        int overlappingRentals =
                Rental.createCriteria().count {

                    eq(
                            'car',
                            car
                    )


                    inList(
                            'status',
                            [
                                    'CONFIRMED',
                                    'PICKED_UP'
                            ]
                    )


                    /*
                     * Overlap formula:
                     *
                     * existing.startDate <= requested.endDate
                     * AND
                     * existing.endDate >= requested.startDate
                     */
                    le(
                            'startDate',
                            endDate
                    )

                    ge(
                            'endDate',
                            startDate
                    )
                }


        if (overlappingRentals > 0) {

            throw new IllegalStateException(
                    'This car is already booked for the selected dates.'
            )
        }


        /*
         * Calculate and lock the agreed rental price.
         *
         * PricingService calculates the price day by day and applies
         * the highest-priority rule for each rental date.
         *
         * The result is stored once in Rental.totalPrice. It is not
         * recalculated later when the deposit is paid or rules change.
         */
        BigDecimal totalPrice =
                pricingService.calculateRentalPrice(
                        car,
                        startDate,
                        endDate
                )


        /*
         * Create rental request.
         *
         * IMPORTANT:
         *
         * status = PENDING
         * depositPaid = false
         *
         * Therefore the reservation is NOT
         * confirmed yet.
         */
        Rental rental =
                new Rental(

                        customer: customer,

                        car: car,

                        startDate: startDate,

                        endDate: endDate,

                        totalPrice: totalPrice,

                        bookingDeposit: 50.00,

                        depositPaid: false,

                        securityDeposit: 200.00,

                        damageCost: 0.00,

                        status: 'PENDING'
                )


        rental.save(
                flush: true,
                failOnError: true
        )


        rental
    }


    /**
     * Simulates paying the booking deposit.
     *
     * For now there is no real payment gateway.
     *
     * In the future, this method should only be
     * called after the electronic payment provider
     * confirms that the payment succeeded.
     *
     * Successful payment:
     *
     * PENDING
     *      ↓
     * depositPaid = true
     *      ↓
     * CONFIRMED
     */
    Rental payDeposit(
            Long rentalId,
            User customer) {


        Rental rental =
                Rental.get(rentalId)


        if (!rental) {

            throw new IllegalArgumentException(
                    'Rental not found.'
            )
        }


        // Customer can pay only for their own rental
        if (rental.customer.id != customer.id) {

            throw new IllegalStateException(
                    'You cannot pay for another customer rental.'
            )
        }


        // Only pending rentals can be confirmed
        if (rental.status != 'PENDING') {

            throw new IllegalStateException(
                    'Deposit can only be paid for a pending rental.'
            )
        }


        // Prevent duplicate payment
        if (rental.depositPaid) {

            throw new IllegalStateException(
                    'Deposit has already been paid.'
            )
        }


        /*
         * IMPORTANT:
         *
         * Another customer may have created
         * a PENDING request for the same dates.
         *
         * Therefore, immediately before confirming
         * this rental, check availability again.
         *
         * First successful deposit wins.
         */
        int overlappingConfirmedRentals =
                Rental.createCriteria().count {

                    eq(
                            'car',
                            rental.car
                    )


                    /*
                     * Ignore the current rental itself.
                     */
                    ne(
                            'id',
                            rental.id
                    )


                    /*
                     * Only actual confirmed bookings
                     * block these dates.
                     */
                    inList(
                            'status',
                            [
                                    'CONFIRMED',
                                    'PICKED_UP'
                            ]
                    )


                    le(
                            'startDate',
                            rental.endDate
                    )


                    ge(
                            'endDate',
                            rental.startDate
                    )
                }


        if (overlappingConfirmedRentals > 0) {

            throw new IllegalStateException(
                    'This car was booked by another customer before your deposit was paid. Please choose different dates.'
            )
        }


        /*
         * SIMULATED PAYMENT SUCCESS.
         *
         * Later this part will happen only after
         * the payment gateway confirms payment.
         */
        rental.depositPaid = true

        rental.status =
                'CONFIRMED'


        rental.save(
                flush: true,
                failOnError: true
        )


        rental
    }


    /**
     * Cancels a customer's rental.
     *
     * PENDING:
     * - Can be cancelled normally.
     * - No booking deposit has been paid.
     *
     * CONFIRMED:
     * - Can also be cancelled.
     * - The already-paid booking deposit is non-refundable.
     *
     * PICKED_UP:
     * - Cannot be cancelled because the vehicle is already
     *   physically with the customer.
     */
    Rental cancelRental(
            Long rentalId,
            User customer) {

        Rental rental =
                Rental.get(rentalId)


        if (!rental) {

            throw new IllegalArgumentException(
                    'Rental not found.'
            )
        }


        if (!customer ||
                rental.customer.id != customer.id) {

            throw new IllegalStateException(
                    'You cannot cancel another customer rental.'
            )
        }


        if (!(rental.status in [
                'PENDING',
                'CONFIRMED'
        ])) {

            throw new IllegalStateException(
                    'Only pending or confirmed rentals can be cancelled.'
            )
        }


        /*
         * IMPORTANT:
         *
         * If the rental is CONFIRMED, depositPaid remains true.
         * We intentionally DO NOT refund or clear the booking deposit.
         * It becomes the non-refundable cancellation cost.
         */
        rental.status =
                'CANCELLED'


        rental.save(
                flush: true,
                failOnError: true
        )


        rental
    }


/**
 * Marks a confirmed rental as picked up.
 *
 * Pickup is allowed only after the booking
 * deposit has been paid and the rental is confirmed.
 */
Rental pickupRental(Long rentalId) {

    Rental rental =
            Rental.get(rentalId)


    if (!rental) {

        throw new IllegalArgumentException(
                'Rental not found.'
        )
    }


    if (rental.status != 'CONFIRMED') {

        throw new IllegalStateException(
                'Only confirmed rentals can be picked up.'
        )
    }


    if (!rental.depositPaid) {

        throw new IllegalStateException(
                'Booking deposit must be paid before vehicle pickup.'
        )
    }


    /*
     * At pickup, the remaining identity,
     * licence, insurance and security-deposit
     * procedures are handled by the rental office.
     */
    rental.status =
            'PICKED_UP'


    /*
     * The car is now physically with the customer.
     */
    rental.car.status =
            'RENTED'


    rental.car.save(
            flush: true,
            failOnError: true
    )


    rental.save(
            flush: true,
            failOnError: true
    )


    rental
}


/**
 * Completes a rental when the vehicle is returned.
 *
 * Damage cost is recorded and the car becomes
 * available again.
 */
Rental completeRental(
        Long rentalId,
        BigDecimal damageCost = 0.00) {

    Rental rental =
            Rental.get(rentalId)


    if (!rental) {

        throw new IllegalArgumentException(
                'Rental not found.'
        )
    }


    if (rental.status != 'PICKED_UP') {

        throw new IllegalStateException(
                'Only picked-up rentals can be completed.'
        )
    }


    if (damageCost == null) {
        damageCost = 0.00
    }


    if (damageCost < 0) {

        throw new IllegalArgumentException(
                'Damage cost cannot be negative.'
        )
    }


    rental.damageCost =
            damageCost


    rental.status =
            'COMPLETED'


    /*
     * Customer returned the vehicle.
     */
    rental.car.status =
            'AVAILABLE'


    rental.car.save(
            flush: true,
            failOnError: true
    )


    rental.save(
            flush: true,
            failOnError: true
    )


    rental
}
    /**
     * Saves an existing rental.
     */
    Rental save(Rental rental) {

        rental.save(
                flush: true,
                failOnError: true
        )


        rental
    }


    /**
     * Deletes a rental by id.
     */
    void delete(Long id) {

        Rental rental =
                Rental.get(id)


        if (!rental) {
            return
        }


        rental.delete(
                flush: true
        )
    }
}
