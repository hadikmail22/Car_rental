package car.rental

import grails.plugin.springsecurity.annotation.Secured

class HomeController {

    def springSecurityService
    PricingService pricingService


    @Secured(['permitAll'])
    def index() {

        if (springSecurityService.isLoggedIn()) {

            User currentUser =
                    springSecurityService.currentUser as User

            boolean isAdmin =
                    currentUser.authorities*.authority.contains(
                            'ROLE_ADMIN'
                    )


            if (isAdmin) {

                redirect(
                        controller: 'dashboard',
                        action: 'index'
                )

            } else {

                redirect(
                        controller: 'car',
                        action: 'index'
                )
            }

            return
        }


        List<Car> availableCarList =
                Car.findAllByStatus(
                        'AVAILABLE',
                        [
                                sort : 'id',
                                order: 'desc'
                        ]
                )

        List<Car> featuredCars =
                availableCarList.take(3)

        List<Car> highestPriceCars =
                availableCarList
                        .toList()
                        .sort { Car first, Car second ->

                            int priceComparison =
                                    (second.pricePerDay ?: 0.0G) <=>
                                    (first.pricePerDay ?: 0.0G)

                            if (priceComparison != 0) {
                                return priceComparison
                            }

                            (second.id ?: 0L) <=>
                                    (first.id ?: 0L)
                        }
                        .take(6)


        Map<Long, List<Map>> pricingHighlightsByCar =
                pricingService.getPricingHighlightsForCars(
                        availableCarList,
                        new Date(),
                        1
                )

        List<Map> activeOfferCars =
                availableCarList.collect { Car car ->

                    Map currentDiscount =
                            (pricingHighlightsByCar[car.id] ?: [])
                                    .find { Map highlight ->

                                        highlight.current == true &&
                                                highlight.adjustmentType ==
                                                'DISCOUNT' &&
                                                highlight.basePrice != null &&
                                                highlight.dailyPrice != null &&
                                                highlight.dailyPrice <
                                                highlight.basePrice
                                    }

                    currentDiscount ?
                            [
                                    car  : car,
                                    offer: currentDiscount
                            ] :
                            null
                }.findAll()

        activeOfferCars.sort { Map first, Map second ->

            int percentageComparison =
                    (second.offer.percentage as BigDecimal) <=>
                    (first.offer.percentage as BigDecimal)

            if (percentageComparison != 0) {
                return percentageComparison
            }

            (second.car.id ?: 0L) <=>
                    (first.car.id ?: 0L)
        }

        Integer activeOfferCount =
                activeOfferCars.size()

        Integer landingCarLimit = 7

        List<Map> landingCars =
                activeOfferCars.take(landingCarLimit)

        Set<Long> selectedCarIds =
                landingCars.collect { Map item ->
                    item.car.id as Long
                }.toSet()

        Integer remainingPlaces =
                landingCarLimit - landingCars.size()

        if (remainingPlaces > 0) {

            availableCarList
                    .findAll { Car car ->
                        !selectedCarIds.contains(car.id)
                    }
                    .take(remainingPlaces)
                    .each { Car car ->

                        landingCars << [
                                car  : car,
                                offer: null
                        ]
                    }
        }


        Long totalCars =
                Car.count()

        Long availableCars =
                Car.countByStatus(
                        'AVAILABLE'
                )


        [
                totalCars    : totalCars,
                availableCars: availableCars,
                featuredCars : featuredCars,
                highestPriceCars: highestPriceCars,
                landingCars  : landingCars,
                activeOfferCount: activeOfferCount
        ]
    }
}
