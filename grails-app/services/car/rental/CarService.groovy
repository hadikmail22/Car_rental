package car.rental

import grails.gorm.transactions.Transactional

@Transactional
class CarService {

    Car get(Long id) {
        Car.get(id)
    }

    List<Car> list(Map params = [:]) {
        Car.list(params)
    }

    Long count() {
        Car.count()
    }

    Car save(Car car) {
        car.save(failOnError: true)
    }

    void delete(Long id) {
        Car car = Car.get(id)

        if (!car) {
            return
        }

        if (car.rentals && !car.rentals.isEmpty()) {
            throw new IllegalStateException(
                'Cannot delete a car that has rental records.'
            )
        }

        car.delete(flush: true)
    }

    def search(String query, Map params = [:]) {

        Car.createCriteria().list(params) {

            if (query) {
                or {
                    ilike('brand', "%${query}%")
                    ilike('model', "%${query}%")
                    ilike('plateNumber', "%${query}%")
                }
            }

            order('id', 'desc')
        }
    }

    Long countByStatus(String status) {
        Car.countByStatus(status)
    }
}