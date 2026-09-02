package car.rental

import grails.gorm.transactions.Transactional
import java.math.RoundingMode

@Transactional
class RentalService {

    PricingService pricingService


    Rental get(Long id) {
        Rental.get(id)
    }


    def listAll(Map params = [:]) {

        Rental.createCriteria().list(params) {
            order('id', 'desc')
        }
    }



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


    def listForCustomer(
            User customer,
            Map params = [:]) {

        Rental.createCriteria().list(params) {

            eq('customer', customer)

            order('id', 'desc')
        }
    }



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


    Rental createRental(
            User customer,
            Long carId,
            Date startDate,
            Date endDate) {


        if (!customer) {

            throw new IllegalArgumentException(
                    'Customer is required.'
            )
        }


        Car car =
                Car.get(carId)


        if (!car) {

            throw new IllegalArgumentException(
                    'Car not found.'
            )
        }


        if (!startDate || !endDate) {

            throw new IllegalArgumentException(
                    'Start date and end date are required.'
            )
        }


        Date today =
                java.sql.Date.valueOf(
                        java.time.LocalDate.now()
                )


        if (startDate.before(today)) {

            throw new IllegalArgumentException(
                    'Start date cannot be in the past.'
            )
        }


        if (endDate.before(startDate)) {

            throw new IllegalArgumentException(
                    'End date cannot be before start date.'
            )
        }


        if (car.status == 'MAINTENANCE') {

            throw new IllegalStateException(
                    'This car is currently under maintenance.'
            )
        }


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


        BigDecimal totalPrice =
                pricingService.calculateRentalPrice(
                        car,
                        startDate,
                        endDate
                )


        Rental rental =
                new Rental(

                        customer: customer,

                        car: car,

                        startDate: startDate,

                        endDate: endDate,

                        totalPrice: totalPrice,

                        systemCalculatedPrice: totalPrice,

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


        if (rental.customer.id != customer.id) {

            throw new IllegalStateException(
                    'You cannot pay for another customer rental.'
            )
        }


        if (rental.status != 'PENDING') {

            throw new IllegalStateException(
                    'Deposit can only be paid for a pending rental.'
            )
        }


        if (rental.depositPaid) {

            throw new IllegalStateException(
                    'Deposit has already been paid.'
            )
        }


        int overlappingConfirmedRentals =
                Rental.createCriteria().count {

                    eq(
                            'car',
                            rental.car
                    )


                    ne(
                            'id',
                            rental.id
                    )


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


        rental.depositPaid = true

        rental.status =
                'CONFIRMED'


        rental.save(
                flush: true,
                failOnError: true
        )


        rental
    }


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


        rental.status =
                'CANCELLED'


        rental.save(
                flush: true,
                failOnError: true
        )


        rental
    }


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


    rental.status =
            'PICKED_UP'


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

    RentalPriceAdjustment adjustRentalPrice(
            Long rentalId,
            BigDecimal newPrice,
            String reason,
            User admin) {

        if (!rentalId) {
            throw new IllegalArgumentException('Rental not found.')
        }

        Rental rental = Rental.lock(rentalId)

        if (!rental) {
            throw new IllegalArgumentException('Rental not found.')
        }

        if (!admin ||
                !admin.authorities*.authority.contains('ROLE_ADMIN')) {
            throw new IllegalStateException(
                    'Only an administrator can change the final rental price.'
            )
        }

        if (!(rental.status in [
                'CONFIRMED',
                'PICKED_UP',
                'COMPLETED'
        ])) {
            throw new IllegalStateException(
                    'The price can only be changed for a confirmed, picked-up or completed rental.'
            )
        }

        if (newPrice == null || newPrice < 0) {
            throw new IllegalArgumentException(
                    'Final rental price must be zero or greater.'
            )
        }

        String cleanReason = reason?.trim()

        if (!cleanReason) {
            throw new IllegalArgumentException(
                    'Please enter the reason for changing the price.'
            )
        }

        if (cleanReason.size() > 500) {
            throw new IllegalArgumentException(
                    'Price adjustment reason cannot exceed 500 characters.'
            )
        }

        BigDecimal normalizedPrice =
                newPrice.setScale(2, RoundingMode.HALF_UP)

        BigDecimal previousPrice =
                (rental.totalPrice ?: 0.00)
                        .setScale(2, RoundingMode.HALF_UP)

        if (normalizedPrice.compareTo(previousPrice) == 0) {
            throw new IllegalStateException(
                    'The entered price is already the current final price.'
            )
        }

        if (rental.systemCalculatedPrice == null) {
            rental.systemCalculatedPrice = previousPrice
        }

        rental.totalPrice = normalizedPrice

        rental.save(
                flush: true,
                failOnError: true
        )

        RentalPriceAdjustment adjustment =
                new RentalPriceAdjustment(
                        rental: rental,
                        adjustedBy: admin,
                        previousPrice: previousPrice,
                        newPrice: normalizedPrice,
                        reason: cleanReason
                )

        adjustment.save(
                flush: true,
                failOnError: true
        )

        adjustment
    }

    Map<Long, List<RentalPriceAdjustment>> getPriceAdjustmentsByRental(
            Collection<Rental> rentals) {

        List<Rental> rentalItems =
                rentals?.findAll { Rental rental -> rental?.id } ?: []

        if (!rentalItems) {
            return [:]
        }

        List<RentalPriceAdjustment> adjustments =
                RentalPriceAdjustment.createCriteria().list {
                    inList('rental', rentalItems)
                    order('dateCreated', 'desc')
                    order('id', 'desc')
                }

        Map<Long, List<RentalPriceAdjustment>> adjustmentsByRental = [:]

        adjustments.each { RentalPriceAdjustment adjustment ->
            Long rentalId = adjustment.rental.id

            if (!adjustmentsByRental.containsKey(rentalId)) {
                adjustmentsByRental[rentalId] = []
            }

            adjustmentsByRental[rentalId].add(adjustment)
        }

        adjustmentsByRental
    }

    Rental save(Rental rental) {

        rental.save(
                flush: true,
                failOnError: true
        )


        rental
    }


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
