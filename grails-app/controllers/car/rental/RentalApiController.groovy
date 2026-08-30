package car.rental

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

class RentalApiController {

    RentalService rentalService
    def springSecurityService

    static allowedMethods = [
            save  : 'POST',
            update: 'PUT',
            delete: 'DELETE'
    ]

    private User currentUser() {
        springSecurityService.currentUser as User
    }

    private boolean isAdmin(User user) {
        user.authorities*.authority.contains('ROLE_ADMIN')
    }

    private boolean canAccess(User user, Rental rental) {
        isAdmin(user) || rental.customer?.id == user.id
    }


    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
    def index() {

        User user = currentUser()

        int max = Math.min(params.int('max') ?: 10, 100)
        int offset = params.int('offset') ?: 0

        def rentalList

if (isAdmin(user)) {

    rentalList =
            rentalService.listForAdmin(
                    [
                            max   : max,
                            offset: offset
                    ]
            )

} else {

    rentalList =
            rentalService.listActiveForCustomer(
                    user,
                    [
                            max   : max,
                            offset: offset
                    ]
            )
}

        def items = rentalList.collect { Rental rental ->

            [
                    id: rental.id,

                    customer: [
                            id      : rental.customer.id,
                            username: rental.customer.username
                    ],

                    car: [
                            id   : rental.car.id,
                            brand: rental.car.brand,
                            model: rental.car.model
                    ],

                    startDate      : rental.startDate,
                    endDate        : rental.endDate,
                    totalPrice     : rental.totalPrice,
                    bookingDeposit : rental.bookingDeposit,
                    depositPaid    : rental.depositPaid,
                    securityDeposit: rental.securityDeposit,
                    damageCost     : rental.damageCost,
                    status         : rental.status
            ]
        }

        render([
                items: items,
                pagination: [
                        total : rentalList.totalCount,
                        max   : max,
                        offset: offset
                ]
        ] as JSON)
    }


    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
    def show(Long id) {

        User user = currentUser()

        Rental rental = rentalService.get(id)

        if (!rental) {
            render status: 404,
                    text: ([error: 'Rental not found.'] as JSON)
            return
        }

        if (!canAccess(user, rental)) {
            render status: 403,
                    text: ([error: 'You cannot access this rental.'] as JSON)
            return
        }

        render([
                id: rental.id,

                customer: [
                        id      : rental.customer.id,
                        username: rental.customer.username
                ],

                car: [
                        id   : rental.car.id,
                        brand: rental.car.brand,
                        model: rental.car.model
                ],

                startDate      : rental.startDate,
                endDate        : rental.endDate,
                totalPrice     : rental.totalPrice,
                bookingDeposit : rental.bookingDeposit,
                depositPaid    : rental.depositPaid,
                securityDeposit: rental.securityDeposit,
                damageCost     : rental.damageCost,
                status         : rental.status
        ] as JSON)
    }


    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
    def save() {

        User loggedUser = currentUser()

        def body = request.JSON

        User customer

        if (isAdmin(loggedUser)) {

            if (!body.customerId) {
                render status: 422,
                        text: ([error: 'customerId is required for admin.'] as JSON)
                return
            }

            customer = User.get(body.customerId as Long)

            if (!customer) {
                render status: 404,
                        text: ([error: 'Customer not found.'] as JSON)
                return
            }

        } else {
            customer = loggedUser
        }

        Date startDate
        Date endDate

        try {

            startDate = java.sql.Date.valueOf(
                    body.startDate.toString()
            )

            endDate = java.sql.Date.valueOf(
                    body.endDate.toString()
            )

        } catch (Exception ignored) {

            render status: 422,
                    text: ([error: 'Valid startDate and endDate are required.'] as JSON)
            return
        }

        try {

            Rental rental = rentalService.createRental(
                    customer,
                    body.carId as Long,
                    startDate,
                    endDate
            )

            response.status = 201

            render([
                    message   : 'Rental created successfully.',
                    id        : rental.id,
                    totalPrice: rental.totalPrice,
                    status    : rental.status
            ] as JSON)

        } catch (IllegalArgumentException e) {

            render status: 422,
                    text: ([error: e.message] as JSON)

        } catch (IllegalStateException e) {

            render status: 409,
                    text: ([error: e.message] as JSON)
        }
    }


    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
    def update(Long id) {

        User user = currentUser()

        Rental rental = rentalService.get(id)

        if (!rental) {
            render status: 404,
                    text: ([error: 'Rental not found.'] as JSON)
            return
        }

        if (!canAccess(user, rental)) {
            render status: 403,
                    text: ([error: 'You cannot update this rental.'] as JSON)
            return
        }

        if (!isAdmin(user) && rental.status != 'PENDING') {
            render status: 409,
                    text: ([error: 'Customers can update only pending rentals.'] as JSON)
            return
        }

        def body = request.JSON

        if (isAdmin(user)) {

            if (body.status != null) {
                rental.status = body.status
            }

            if (body.damageCost != null) {
                rental.damageCost =
                        body.damageCost as BigDecimal
            }

            if (body.depositPaid != null) {
                rental.depositPaid =
                        body.depositPaid as Boolean
            }
        }

        if (!rental.validate()) {

            render status: 422,
                    text: ([error: 'Validation failed.'] as JSON)
            return
        }

        rentalService.save(rental)
        render([
                message: 'Rental updated successfully.',
                id     : rental.id,
                status : rental.status
        ] as JSON)
    }


    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
    def delete(Long id) {

        User user = currentUser()

        Rental rental = rentalService.get(id)

        if (!rental) {
            render status: 404,
                    text: ([error: 'Rental not found.'] as JSON)
            return
        }

        if (!canAccess(user, rental)) {
            render status: 403,
                    text: ([error: 'You cannot delete this rental.'] as JSON)
            return
        }

        if (!isAdmin(user) && rental.status != 'PENDING') {
            render status: 409,
                    text: ([error: 'Customers can delete only pending rentals.'] as JSON)
            return
        }

        rentalService.delete(id)
        render status: 204, text: ''
    }
}