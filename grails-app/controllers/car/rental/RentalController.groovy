package car.rental

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

class RentalController {

    RentalService rentalService
    PricingService pricingService
    def springSecurityService

    static allowedMethods = [
        save      : 'POST',
        quote     : 'GET',
        payDeposit: 'POST',
        cancel    : 'POST',
        adjustPrice: 'POST',
        pickup    : 'POST',
        complete  : 'POST'
    ]


    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
    def index() {

        params.max =
                Math.min(
                        params.int('max') ?: 10,
                        100
                )

        params.offset =
                params.int('offset') ?: 0


        User currentUser =
                springSecurityService.currentUser as User


        boolean isAdmin =
                currentUser.authorities*.authority.contains(
                        'ROLE_ADMIN'
                )


        if (isAdmin) {

            def rentalList =
                    rentalService.listForAdmin(
                            [
                                    max   : params.max,
                                    offset: params.offset
                            ]
                    )


            Set<Long> pickupDueTodayIds =
                    rentalService.getPickupDueTodayIds()


            Set<Long> returnDueTodayIds =
                    rentalService.getReturnDueTodayIds()


            Map<Long, List<RentalPriceAdjustment>> priceAdjustmentsByRental =
                    rentalService.getPriceAdjustmentsByRental(rentalList)


            return [
                    rentalList        : rentalList,
                    rentalCount       : rentalList.totalCount,
                    pickupDueTodayIds : pickupDueTodayIds,
                    returnDueTodayIds : returnDueTodayIds,
                    priceAdjustmentsByRental: priceAdjustmentsByRental
            ]
        }


        def rentalList =
                rentalService.listActiveForCustomer(
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
    def history() {

        params.max =
                Math.min(
                        params.int('max') ?: 10,
                        100
                )

        params.offset =
                params.int('offset') ?: 0


        User currentUser =
                springSecurityService.currentUser as User


        def rentalList =
                rentalService.listHistoryForCustomer(
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

        Car car =
                Car.get(carId)


        if (!car) {

            flash.message =
                    'Car not found.'

            redirect(
                    controller: 'car',
                    action: 'index'
            )

            return
        }


        def bookings =
                rentalService.getActiveBookingsForCar(
                        car
                )


        [
                car                 : car,
                bookings            : bookings,
                durationPricingTiers:
                        pricingService.durationPricingTiers
        ]
    }


    @Secured(['ROLE_CUSTOMER'])
    def quote() {

        Long carId =
                params.long('carId')


        Car car =
                carId ?
                        Car.get(carId) :
                        null


        if (!car) {

            response.status = 404

            render([
                    error: 'Car not found.'
            ] as JSON)

            return
        }


        Date startDate
        Date endDate


        try {

            startDate =
                    java.sql.Date.valueOf(
                            params.startDate?.toString()
                    )

            endDate =
                    java.sql.Date.valueOf(
                            params.endDate?.toString()
                    )

        } catch (Exception ignored) {

            response.status = 422

            render([
                    error:
                            'Please select valid start and end dates.'
            ] as JSON)

            return
        }


        try {

            Map rentalQuote =
                    pricingService.calculateRentalQuote(
                            car,
                            startDate,
                            endDate
                    )


            render rentalQuote as JSON

        } catch (
                IllegalArgumentException |
                IllegalStateException exception
        ) {

            response.status = 422

            render([
                    error: exception.message
            ] as JSON)
        }
    }


    @Secured(['ROLE_CUSTOMER'])
    def save() {

        User customer =
                springSecurityService.currentUser as User


        Long carId =
                params.long('carId')


        Date startDate
        Date endDate


        try {

            startDate =
                    java.sql.Date.valueOf(
                            params.startDate
                    )

            endDate =
                    java.sql.Date.valueOf(
                            params.endDate
                    )

        } catch (Exception e) {

            flash.message =
                    'Please select valid start and end dates.'


            redirect(
                    action: 'create',
                    params: [
                            carId: carId
                    ]
            )

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
                    "Rental created successfully. " +
                    "Pay the booking deposit of ${rental.bookingDeposit} " +
                    "to confirm your reservation."


            redirect(
                    action: 'index'
            )

        } catch (
                IllegalArgumentException |
                IllegalStateException e
        ) {

            flash.message =
                    e.message


            redirect(
                    action: 'create',
                    params: [
                            carId: carId
                    ]
            )
        }
    }


    @Secured(['ROLE_CUSTOMER'])
    def payDeposit(Long id) {

        User customer =
                springSecurityService.currentUser as User


        try {

            rentalService.payDeposit(
                    id,
                    customer
            )


            flash.message =
                    'Booking deposit paid successfully. ' +
                    'Rental is now confirmed.'

        } catch (
                IllegalArgumentException |
                IllegalStateException e
        ) {

            flash.message =
                    e.message
        }


        redirect(
                action: 'index'
        )
    }



    @Secured(['ROLE_CUSTOMER'])
    def cancel(Long id) {

        User customer =
                springSecurityService.currentUser as User


        try {

            Rental rental =
                    rentalService.cancelRental(
                            id,
                            customer
                    )


            if (rental.depositPaid) {

                flash.message =
                        "Rental cancelled. " +
                        "The booking deposit of ${rental.bookingDeposit} " +
                        "is non-refundable."

            } else {

                flash.message =
                        'Rental cancelled successfully.'
            }

        } catch (
                IllegalArgumentException |
                IllegalStateException e
        ) {

            flash.message =
                    e.message
        }


        redirect(
                action: 'index'
        )
    }


    @Secured(['ROLE_ADMIN'])
    def adjustPrice(Long id) {

        User admin =
                springSecurityService.currentUser as User


        try {

            String finalPriceValue =
                    params.finalPrice
                            ?.toString()
                            ?.trim()


            if (!finalPriceValue) {
                throw new NumberFormatException()
            }


            BigDecimal finalPrice =
                    new BigDecimal(
                            finalPriceValue
                    )


            RentalPriceAdjustment adjustment =
                    rentalService.adjustRentalPrice(
                            id,
                            finalPrice,
                            params.reason?.toString(),
                            admin
                    )


            BigDecimal difference =
                    adjustment.newPrice -
                    adjustment.previousPrice


            String differenceText =
                    difference < 0 ?
                            "discount ${difference.abs()}" :
                            "increase ${difference}"


            flash.message =
                    "Final rental price changed from " +
                    "${adjustment.previousPrice} to " +
                    "${adjustment.newPrice} (${differenceText})."

        } catch (NumberFormatException e) {

            flash.message =
                    'Final rental price must be a valid number.'

        } catch (
                IllegalArgumentException |
                IllegalStateException e
        ) {

            flash.message =
                    e.message
        }


        redirect(
                action: 'index'
        )
    }


    @Secured(['ROLE_ADMIN'])
    def pickup(Long id) {

        try {

            Rental rental =
                    rentalService.pickupRental(id)


            flash.message =
                    "Vehicle pickup completed for " +
                    "${rental.car.brand} ${rental.car.model}. " +
                    "Insurance, licence verification and security " +
                    "deposit procedures are considered completed."

        } catch (
                IllegalArgumentException |
                IllegalStateException e
        ) {

            flash.message =
                    e.message
        }


        redirect(
                action: 'index'
        )
    }


    @Secured(['ROLE_ADMIN'])
    def complete(Long id) {

        BigDecimal damageCost =
                0.00


        try {

            if (params.damageCost) {

                damageCost =
                        new BigDecimal(
                                params.damageCost.toString()
                        )
            }


            Rental rental =
                    rentalService.completeRental(
                            id,
                            damageCost
                    )


            BigDecimal securityRefund =
                    rental.securityDeposit -
                    rental.damageCost


            if (securityRefund < 0) {
                securityRefund = 0.00
            }


            BigDecimal rentalCredit =
                    rental.depositPaid &&
                    rental.bookingDeposit > rental.totalPrice ?
                            rental.bookingDeposit -
                            rental.totalPrice :
                            0.00


            BigDecimal totalRefund =
                    securityRefund +
                    rentalCredit


            flash.message =
                    "Rental completed. " +
                    "Damage cost: ${rental.damageCost}. " +
                    "Total amount to return to the customer: ${totalRefund}."

        } catch (NumberFormatException e) {

            flash.message =
                    'Damage cost must be a valid number.'

        } catch (
                IllegalArgumentException |
                IllegalStateException e
        ) {

            flash.message =
                    e.message
        }


        redirect(
                action: 'index'
        )
    }
}
