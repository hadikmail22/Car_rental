package car.rental

import grails.gorm.transactions.Transactional

@Transactional
class RentalService {

    Rental get(Long id) {
        Rental.get(id)
    }


    def listAll(Map params = [:]) {
        Rental.createCriteria().list(params) {
            order('id', 'desc')
        }
    }


    def listForCustomer(User customer, Map params = [:]) {
        Rental.createCriteria().list(params) {
            eq('customer', customer)
            order('id', 'desc')
        }
    }


    /*
     * Return all bookings that currently block
     * this car from being rented.
     */
    List<Rental> getActiveBookingsForCar(Car car) {

        if (!car) {
            return []
        }

        Rental.findAllByCarAndStatusInList(
                car,
                [
                        'PENDING',
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


        Car car = Car.get(carId)

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


        /*
         * Prevent overlapping rentals.
         *
         * Existing:
         * 10 Aug -------- 15 Aug
         *
         * New:
         *       12 Aug -------- 18 Aug
         *
         * = overlap
         */
        int overlappingRentals =
                Rental.createCriteria().count {

                    eq('car', car)

                    inList(
                            'status',
                            [
                                    'PENDING',
                                    'CONFIRMED',
                                    'PICKED_UP'
                            ]
                    )

                    le('startDate', endDate)
                    ge('endDate', startDate)
                }


        if (overlappingRentals > 0) {
            throw new IllegalStateException(
                    'This car is already booked for the selected dates.'
            )
        }


        // Calculate rental days
        long milliseconds =
                endDate.time - startDate.time

        long rentalDays =
                (milliseconds / (1000 * 60 * 60 * 24)) + 1


        if (rentalDays < 1) {
            rentalDays = 1
        }


        // Calculate final price
        BigDecimal totalPrice =
                car.pricePerDay * rentalDays


        Rental rental = new Rental(
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
                failOnError: true,
                flush: true
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


        rental.depositPaid = true
        rental.status = 'CONFIRMED'


        rental.save(
                flush: true,
                failOnError: true
        )


        rental
    }
}