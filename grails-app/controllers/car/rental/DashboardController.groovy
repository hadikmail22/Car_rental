package car.rental

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class DashboardController {

    CarService carService

    def index() {

        [
            totalCars      : carService.count(),
            availableCars  : carService.countByStatus('AVAILABLE'),
            rentedCars     : carService.countByStatus('RENTED'),
            maintenanceCars: carService.countByStatus('MAINTENANCE')
        ]
    }
}