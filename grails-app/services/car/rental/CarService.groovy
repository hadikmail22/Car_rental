package car.rental

import grails.gorm.transactions.Transactional

@Transactional
class CarService {

    /**
     * Returns a car by its id.
     *
     * @param id car id
     * @return matching car or null if not found
     */
    Car get(Long id) {
        Car.get(id)
    }

    /**
     * Returns a paginated list of cars.
     *
     * @param params pagination and query parameters
     * @return list of cars
     */
    List<Car> list(Map params = [:]) {
        Car.list(params)
    }

    /**
     * Returns the total number of cars.
     *
     * @return total car count
     */
    Long count() {
        Car.count()
    }

    /**
     * Saves a car.
     *
     * @param car car to save
     * @return saved car
     */
    Car save(Car car) {
        car.save(failOnError: true)
    }

    /**
     * Deletes a car if it has no rental records.
     *
     * @param id car id
     * @throws IllegalStateException when the car has rental records
     */
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
        CarImage.findAllByCar(car).each { CarImage image ->
    image.delete(failOnError: true)
}

        car.delete(flush: true)
    }

    /**
     * Searches cars by brand, model, or plate number.
     *
     * @param query search text
     * @param params pagination parameters
     * @return filtered car list
     */
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

    /**
     * Counts cars by status.
     *
     * @param status car status
     * @return number of cars with the given status
     */
    Long countByStatus(String status) {
        Car.countByStatus(status)
    }

    Car saveWithGallery(
        Car car,
        List<Map> galleryFiles) {

    car.save(
            flush: true,
            failOnError: true
    )

    galleryFiles.each { file ->

        CarImage carImage =
                new CarImage(
                        car: car,
                        imageData: file.bytes as byte[],
                        contentType: file.contentType as String
                )

        carImage.save(
                failOnError: true
        )
    }

    car
}
Car updateWithGallery(
        Car car,
        List<Map> galleryFiles) {

    car.save(
            failOnError: true
    )

    galleryFiles.each { file ->

        new CarImage(
                car: car,
                imageData: file.bytes as byte[],
                contentType: file.contentType as String
        ).save(
                failOnError: true
        )
    }

    car
}


int countGalleryImages(Long carId) {

    Car car = Car.get(carId)

    if (!car) {
        return 0
    }

    CarImage.countByCar(car)
}


CarImage replaceGalleryImage(
        Long imageId,
        Long carId,
        byte[] bytes,
        String contentType) {

    Car car = Car.get(carId)

    if (!car) {
        throw new IllegalArgumentException(
                'Car not found.'
        )
    }

    CarImage image =
            CarImage.findByIdAndCar(
                    imageId,
                    car
            )

    if (!image) {
        throw new IllegalArgumentException(
                'Gallery image not found.'
        )
    }

    image.imageData = bytes
    image.contentType = contentType

    image.save(
            flush: true,
            failOnError: true
    )

    image
}


void deleteGalleryImage(
        Long imageId,
        Long carId) {

    Car car = Car.get(carId)

    if (!car) {
        throw new IllegalArgumentException(
                'Car not found.'
        )
    }

    CarImage image =
            CarImage.findByIdAndCar(
                    imageId,
                    car
            )

    if (!image) {
        throw new IllegalArgumentException(
                'Gallery image not found.'
        )
    }

    image.delete(
            flush: true,
            failOnError: true
    )
}
}