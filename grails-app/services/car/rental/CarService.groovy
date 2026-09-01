package car.rental

import grails.gorm.transactions.Transactional

@Transactional
class CarService {

    /**
     * Returns a car by its id.
     */
    Car get(Long id) {
        Car.get(id)
    }


    /**
     * Returns a paginated list of cars.
     */
    List<Car> list(Map params = [:]) {
        Car.list(params)
    }


    /**
     * Returns the total number of cars.
     */
    Long count() {
        Car.count()
    }


    /**
     * Saves a car.
     */
    Car save(Car car) {

        car.save(
                failOnError: true
        )
    }


    /**
     * Deletes a car if it has no rental records.
     *
     * Pricing rules and gallery images belonging
     * to the car are deleted first to avoid
     * foreign-key errors.
     */
    void delete(Long id) {

        Car car =
                Car.get(id)

        if (!car) {
            return
        }


        /*
         * A car that has rental history cannot
         * be deleted.
         */
        if (car.rentals &&
                !car.rentals.isEmpty()) {

            throw new IllegalStateException(
                    'Cannot delete a car that has rental records.'
            )
        }


        /*
         * Pricing rules no longer need to remain
         * when the car itself is deleted.
         *
         * Existing rentals are not affected because
         * their agreed price is stored in Rental.totalPrice.
         */
        PricingRule
                .findAllByCar(car)
                .each { PricingRule pricingRule ->

                    pricingRule.delete(
                            failOnError: true
                    )
                }


        /*
         * Delete gallery images before deleting
         * the car to avoid the CarImage foreign key.
         */
        CarImage
                .findAllByCar(car)
                .each { CarImage image ->

                    image.delete(
                            failOnError: true
                    )
                }


        car.delete(
                flush: true,
                failOnError: true
        )
    }


    /**
     * Searches cars by brand, model,
     * plate number, or category name.
     */
    def search(
            String query,
            CarCategory selectedCategory,
            Map params = [:]) {

        String normalizedQuery =
                query?.trim()


        List<CarCategory> matchingCategories =
                normalizedQuery ?
                        CarCategory.findAllByNameIlike(
                                "%${normalizedQuery}%"
                        ) :
                        []


        Car.createCriteria().list(params) {

            if (normalizedQuery) {

                or {

                    ilike(
                            'brand',
                            "%${normalizedQuery}%"
                    )

                    ilike(
                            'model',
                            "%${normalizedQuery}%"
                    )

                    ilike(
                            'plateNumber',
                            "%${normalizedQuery}%"
                    )

                    if (matchingCategories) {

                        inList(
                                'category',
                                matchingCategories
                        )
                    }
                }
            }


            if (selectedCategory) {

                eq(
                        'category',
                        selectedCategory
                )
            }


            order(
                    'id',
                    'desc'
            )
        }
    }


    /**
     * Counts cars by status.
     */
    Long countByStatus(String status) {

        Car.countByStatus(status)
    }


    /**
     * Saves a car together with its
     * additional gallery images.
     */
    Car saveWithGallery(
            Car car,
            List<Map> galleryFiles) {

        car.save(
                flush: true,
                failOnError: true
        )


        galleryFiles.each { Map file ->

            CarImage carImage =
                    new CarImage(
                            car: car,
                            imageData:
                                    file.bytes as byte[],
                            contentType:
                                    file.contentType as String
                    )


            carImage.save(
                    failOnError: true
            )
        }


        car
    }


    /**
     * Updates a car and adds new gallery images.
     */
    Car updateWithGallery(
            Car car,
            List<Map> galleryFiles) {

        car.save(
                failOnError: true
        )


        galleryFiles.each { Map file ->

            new CarImage(
                    car: car,
                    imageData:
                            file.bytes as byte[],
                    contentType:
                            file.contentType as String
            ).save(
                    failOnError: true
            )
        }


        car
    }


    /**
     * Counts additional gallery images
     * for one car.
     */
    int countGalleryImages(Long carId) {

        Car car =
                Car.get(carId)


        if (!car) {
            return 0
        }


        CarImage.countByCar(car)
    }


    /**
     * Replaces one existing gallery image.
     */
    CarImage replaceGalleryImage(
            Long imageId,
            Long carId,
            byte[] bytes,
            String contentType) {

        Car car =
                Car.get(carId)


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


        image.imageData =
                bytes

        image.contentType =
                contentType


        image.save(
                flush: true,
                failOnError: true
        )


        image
    }


    /**
     * Deletes one gallery image.
     */
    void deleteGalleryImage(
            Long imageId,
            Long carId) {

        Car car =
                Car.get(carId)


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