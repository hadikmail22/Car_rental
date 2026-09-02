package car.rental

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile

class CarController {

    CarService carService
    PricingService pricingService

    private Map formModel(Car car) {
        [
                car         : car,
                categoryList: CarCategory.list(
                        sort: 'name',
                        order: 'asc'
                )
        ]
    }

static allowedMethods = [
        save               : 'POST',
        update             : 'PUT',
        delete             : 'DELETE',
        deleteGalleryImage : 'POST',
        replaceGalleryImage: 'POST'
]
    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
    def index() {
        params.max = Math.min(params.int('max') ?: 6, 100)
        params.offset = params.int('offset') ?: 0

        Long categoryId =
                params.long('categoryId')

        CarCategory selectedCategory =
                categoryId ?
                        CarCategory.get(categoryId) :
                        null

        BigDecimal minPrice =
                parsePrice(params.minPrice)

        BigDecimal maxPrice =
                parsePrice(params.maxPrice)

        boolean offersOnly =
                params.offersOnly in [
                        true,
                        'true',
                        'on',
                        '1'
                ]

        String priceRangeError =
                minPrice != null &&
                        maxPrice != null &&
                        minPrice > maxPrice ?
                        'Minimum price cannot exceed maximum price.' :
                        null

        List<Car> matchingCars =
                carService.search(
                params.q,
                selectedCategory,
                [:]
                ) as List<Car>

        Map<Long, List<Map>> pricingHighlightsByCar =
                pricingService.getPricingHighlightsForCars(
                        matchingCars
                )

        Map<Long, Map> currentPricingByCar = [:]

        matchingCars.each { Car car ->

            Map currentHighlight =
                    (pricingHighlightsByCar[car.id] ?: [])
                            .find { Map highlight ->
                                highlight.current == true
                            }

            BigDecimal effectivePrice =
                    currentHighlight?.dailyPrice != null ?
                            currentHighlight.dailyPrice as BigDecimal :
                            car.pricePerDay

            boolean activeDiscount =
                    currentHighlight?.adjustmentType ==
                            'DISCOUNT' &&
                            effectivePrice < car.pricePerDay

            currentPricingByCar[car.id] = [
                    effectivePrice : effectivePrice,
                    activeDiscount : activeDiscount,
                    currentHighlight: currentHighlight
            ]
        }

        List<Car> filteredCars =
                priceRangeError ?
                        [] :
                        matchingCars.findAll { Car car ->

                            Map currentPricing =
                                    currentPricingByCar[car.id]

                            BigDecimal effectivePrice =
                                    currentPricing.effectivePrice as BigDecimal

                            if (offersOnly &&
                                    !currentPricing.activeDiscount) {
                                return false
                            }

                            if (minPrice != null &&
                                    effectivePrice < minPrice) {
                                return false
                            }

                            if (maxPrice != null &&
                                    effectivePrice > maxPrice) {
                                return false
                            }

                            true
                        }

        Integer carCount =
                filteredCars.size()

        List<Car> carList =
                filteredCars
                        .drop(params.offset)
                        .take(params.max)

        boolean hasFilters =
                params.q?.trim() ||
                        selectedCategory ||
                        minPrice != null ||
                        maxPrice != null ||
                        offersOnly

        [
                carList : carList,
                carCount: carCount,
                q       : params.q,
                categoryList: CarCategory.list(
                        sort: 'name',
                        order: 'asc'
                ),
                categoryId: selectedCategory?.id,
                pricingHighlightsByCar:
                        pricingHighlightsByCar,
                currentPricingByCar:
                        currentPricingByCar,
                minPrice: minPrice,
                maxPrice: maxPrice,
                offersOnly: offersOnly,
                priceRangeError: priceRangeError,
                hasFilters: hasFilters
        ]
    }

    private BigDecimal parsePrice(Object value) {

        String normalizedValue =
                value?.toString()?.trim()

        if (!normalizedValue) {
            return null
        }

        try {

            BigDecimal price =
                    new BigDecimal(normalizedValue)

            price >= 0G ?
                    price :
                    null

        } catch (NumberFormatException ignored) {
            null
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
    def show(Long id) {
        Car car = carService.get(id)

        if (!car) {
            notFound()
            return
        }

        Map<Long, List<Map>> pricingHighlightsByCar =
                pricingService.getPricingHighlightsForCars(
                        [car]
                )

        [
                car              : car,
                pricingHighlights:
                        pricingHighlightsByCar[car.id] ?: []
        ]
    }

    @Secured(['ROLE_ADMIN'])
    def create() {
        formModel(new Car())
    }

 @Secured(['ROLE_ADMIN'])
def save(Car car) {

    if (car == null) {
        notFound()
        return
    }

    Long categoryId =
            params.long('categoryId')

    CarCategory category =
            categoryId ?
                    CarCategory.get(categoryId) :
                    null

    if (!category) {

        car.errors.rejectValue(
                'category',
                'car.category.required',
                'Please select a valid category.'
        )

        render view: 'create',
                model: formModel(car)

        return
    }

    car.category = category

    MultipartFile image =
            request.getFile('carImage')

    if (image && !image.empty) {

        if (!image.contentType?.startsWith('image/')) {
            flash.message =
                    'Only image files are allowed.'

            render view: 'create',
                    model: formModel(car)

            return
        }

        if (image.size >= 10 * 1024 * 1024) {
            flash.message =
                    'Car image must be smaller than 10MB.'

            render view: 'create',
                    model: formModel(car)

            return
        }

        car.carImage =
                image.bytes

        car.imageContentType =
                image.contentType
    }


    List<MultipartFile> galleryImages =
        request.getFiles('newGalleryImages')
    galleryImages =
            galleryImages.findAll {
                it && !it.empty
            }


    if (galleryImages.size() > 6) {

        flash.message =
                'You can upload a maximum of 6 additional images.'

        render view: 'create',
                model: formModel(car)

        return
    }


    for (MultipartFile galleryImage : galleryImages) {

        if (!galleryImage.contentType?.startsWith('image/')) {

            flash.message =
                    'Only image files are allowed in the gallery.'

            render view: 'create',
                    model: formModel(car)

            return
        }

        if (galleryImage.size >= 5 * 1024 * 1024) {

            flash.message =
                    'Each gallery image must be smaller than 5MB.'

            render view: 'create',
                    model: formModel(car)

            return
        }
    }


    if (car.hasErrors()) {

        render view: 'create',
                model: formModel(car)

        return
    }


    def galleryFiles =
            galleryImages.collect { MultipartFile galleryImage ->

                [
                        bytes      : galleryImage.bytes,
                        contentType: galleryImage.contentType
                ]
            }


    carService.saveWithGallery(
            car,
            galleryFiles
    )


    println "GALLERY FILES RECEIVED: ${galleryImages.size()}"
    println "CAR IMAGES IN DATABASE: ${CarImage.countByCar(car)}"


    flash.message =
            'Car created successfully.'

    redirect action: 'show',
            id: car.id
}

    @Secured(['ROLE_ADMIN'])
    def edit(Long id) {

        Car car = carService.get(id)

        if (!car) {
            notFound()
            return
        }

        formModel(car)
    }


@Secured(['ROLE_ADMIN'])
def update(Long id) {

    Car car = carService.get(id)

    if (!car) {
        notFound()
        return
    }

    Long categoryId =
            params.long('categoryId')

    CarCategory category =
            categoryId ?
                    CarCategory.get(categoryId) :
                    null

    if (!category) {

        car.errors.rejectValue(
                'category',
                'car.category.required',
                'Please select a valid category.'
        )

        render view: 'edit',
                model: formModel(car)

        return
    }

    car.category = category


    car.brand = params.brand
    car.model = params.model

    if (params.year) {
        car.year = params.int('year')
    }

    car.plateNumber = params.plateNumber

    if (params.pricePerDay) {
        car.pricePerDay =
                new BigDecimal(params.pricePerDay)
    }

    car.status = params.status


    MultipartFile image =
            request.getFile('newCarImage')

    if (image && !image.empty) {

        if (!image.contentType?.startsWith('image/')) {

            flash.message =
                    'Only image files are allowed.'

            render view: 'edit',
                    model: formModel(car)

            return
        }

        if (image.size >= 10 * 1024 * 1024) {

            flash.message =
                    'Car image must be smaller than 10MB.'

            render view: 'edit',
                    model: formModel(car)

            return
        }

        car.carImage = image.bytes
        car.imageContentType = image.contentType
    }


    List<MultipartFile> galleryImages =
            request.getFiles('newGalleryImages')

    galleryImages =
            galleryImages.findAll {
                it && !it.empty
            }


    int currentGalleryCount =
            carService.countGalleryImages(car.id)

    if (currentGalleryCount + galleryImages.size() > 6) {

        flash.message =
                'A car can have a maximum of 6 additional images.'

        render view: 'edit',
                model: formModel(car)

        return
    }


    for (MultipartFile galleryImage : galleryImages) {

        if (!galleryImage.contentType?.startsWith('image/')) {

            flash.message =
                    'Only image files are allowed in the gallery.'

            render view: 'edit',
                    model: formModel(car)

            return
        }

        if (galleryImage.size >= 5 * 1024 * 1024) {

            flash.message =
                    'Each gallery image must be smaller than 5MB.'

            render view: 'edit',
                    model: formModel(car)

            return
        }
    }


    if (!car.validate()) {

        render view: 'edit',
                model: formModel(car)

        return
    }


    def galleryFiles =
            galleryImages.collect { MultipartFile galleryImage ->

                [
                        bytes      : galleryImage.bytes,
                        contentType: galleryImage.contentType
                ]
            }


    carService.updateWithGallery(
            car,
            galleryFiles
    )


    flash.message =
            'Car updated successfully.'

    redirect action: 'show',
            id: car.id
}

    @Secured(['ROLE_ADMIN'])
    def delete(Long id) {

        try {
            carService.delete(id)

            flash.message = 'Car deleted successfully.'

            redirect action: 'index'

        } catch (IllegalStateException e) {

            flash.message = e.message

            redirect action: 'show', id: id
        }
    }

    @Secured(['permitAll'])
def image(Long id) {

    Car car = carService.get(id)

    if (!car || !car.carImage) {
        render status: 404
        return
    }

    response.contentType =
            car.imageContentType ?: 'image/jpeg'

    response.outputStream << car.carImage
    response.outputStream.flush()
}

    protected void notFound() {
        flash.message = 'Car not found.'
        redirect action: 'index'
    }

    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
def galleryImage(Long id) {

    CarImage image = CarImage.get(id)

    if (!image || !image.imageData) {
        render status: 404
        return
    }

    response.contentType =
            image.contentType ?: 'image/jpeg'

    response.outputStream << image.imageData
    response.outputStream.flush()
}
@Secured(['ROLE_ADMIN'])
def deleteGalleryImage(Long id) {

    Long carId =
            params.long('carId')

    try {

        carService.deleteGalleryImage(
                id,
                carId
        )

        flash.message =
                'Gallery image deleted successfully.'

    } catch (IllegalArgumentException e) {

        flash.message =
                e.message
    }

    redirect action: 'edit',
            id: carId
}
@Secured(['ROLE_ADMIN'])
def replaceGalleryImage(Long id) {

    Long carId =
            params.long('carId')

    MultipartFile image =
            request.getFile('replacementImage')


    if (!image || image.empty) {

        flash.message =
                'Please select a replacement image.'

        redirect action: 'edit',
                id: carId

        return
    }


    if (!image.contentType?.startsWith('image/')) {

        flash.message =
                'Only image files are allowed.'

        redirect action: 'edit',
                id: carId

        return
    }


    if (image.size >= 5 * 1024 * 1024) {

        flash.message =
                'Gallery image must be smaller than 5MB.'

        redirect action: 'edit',
                id: carId

        return
    }


    try {

        carService.replaceGalleryImage(
                id,
                carId,
                image.bytes,
                image.contentType
        )

        flash.message =
                'Gallery image replaced successfully.'

    } catch (IllegalArgumentException e) {

        flash.message =
                e.message
    }


    redirect action: 'edit',
            id: carId
}
}
