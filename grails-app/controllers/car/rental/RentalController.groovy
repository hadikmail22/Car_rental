package car.rental

import grails.plugin.springsecurity.annotation.Secured

class RentalController {

    RentalService rentalService
    def springSecurityService

    static allowedMethods = [
        save      : 'POST',
        payDeposit: 'POST'
]


    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
def index() {

    params.max = Math.min(params.int('max') ?: 10, 100)
    params.offset = params.int('offset') ?: 0

    User currentUser =
            springSecurityService.currentUser as User

    boolean isAdmin =
            currentUser.authorities*.authority.contains('ROLE_ADMIN')

    if (isAdmin) {

        def rentalList =
                rentalService.listAll(
                        [
                                max   : params.max,
                                offset: params.offset
                        ]
                )

        return [
                rentalList : rentalList,
                rentalCount: rentalList.totalCount
        ]
    }

    def rentalList =
            rentalService.listForCustomer(
                    currentUser,
                    [
                            max   : params.max,
                            offset: params.offset
                    ]
            )

    [
            rentalList : rentalList,
            rentalCount: rentalList.totalCount
    ]
}


    @Secured(['ROLE_CUSTOMER'])
    def create(Long carId) {

        Car car = Car.get(carId)

        if (!car) {
            flash.message = 'Car not found.'
            redirect controller: 'car', action: 'index'
            return
        }

        def bookings =
        rentalService.getActiveBookingsForCar(car)

[
        car     : car,
        bookings: bookings
]
    }


    @Secured(['ROLE_CUSTOMER'])
    def save() {

        User customer =
                springSecurityService.currentUser as User


        Long carId = params.long('carId')

        Date startDate
        Date endDate


        try {

            startDate =
                    java.sql.Date.valueOf(params.startDate)

            endDate =
                    java.sql.Date.valueOf(params.endDate)

        } catch (Exception e) {

            flash.message =
                    'Please select valid start and end dates.'

            redirect action: 'create', params: [carId: carId]
            return
        }


        try {

            Rental rental =
                    rentalService.createRental(
                            customer,
                            carId,
                            startDate,
                            endDate
                    )

            flash.message =
                    "Rental created successfully. Total price: ${rental.totalPrice}"

            redirect action: 'index'

        } catch (IllegalArgumentException |
                 IllegalStateException e) {

            flash.message = e.message

            redirect action: 'create',
                    params: [carId: carId]
        }
    }
    @Secured(['ROLE_CUSTOMER'])
def payDeposit(Long id) {

    User customer =
            springSecurityService.currentUser as User

    try {

        Rental rental =
                rentalService.payDeposit(
                        id,
                        customer
                )

        flash.message =
                "Booking deposit paid successfully. Rental is now confirmed."

    } catch (IllegalArgumentException |
             IllegalStateException e) {

        flash.message = e.message
    }

    redirect action: 'index'
}
}