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

        def carList = carService.search(
                params.q,
                selectedCategory,
                [
                        max   : params.max,
                        offset: params.offset
                ]
        )

        Map<Long, List<Map>> pricingHighlightsByCar =
                pricingService.getPricingHighlightsForCars(
                        carList
                )

        [
                carList : carList,
                carCount: carList.totalCount,
                q       : params.q,
                categoryList: CarCategory.list(
                        sort: 'name',
                        order: 'asc'
                ),
                categoryId: selectedCategory?.id,
                pricingHighlightsByCar:
                        pricingHighlightsByCar
        ]
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

    // Main image
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


    // Additional gallery images
    List<MultipartFile> galleryImages =
        request.getFiles('newGalleryImages')
    galleryImages =
            galleryImages.findAll {
                it && !it.empty
            }


    // Maximum 6 additional images
    if (galleryImages.size() > 6) {

        flash.message =
                'You can upload a maximum of 6 additional images.'

        render view: 'create',
                model: formModel(car)

        return
    }


    // Validate every gallery image
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


    // Validate car fields
    if (car.hasErrors()) {

        render view: 'create',
                model: formModel(car)

        return
    }


    /*
     * Convert MultipartFile objects
     * into simple data maps.
     *
     * The Service will save everything
     * inside a transaction.
     */
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


    // Temporary debugging
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


    // Update normal car fields manually
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


    // Main image
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


    // New gallery uploads
    List<MultipartFile> galleryImages =
            request.getFiles('newGalleryImages')

    galleryImages =
            galleryImages.findAll {
                it && !it.empty
            }


    // Maximum gallery size
    int currentGalleryCount =
            carService.countGalleryImages(car.id)

    if (currentGalleryCount + galleryImages.size() > 6) {

        flash.message =
                'A car can have a maximum of 6 additional images.'

        render view: 'edit',
                model: formModel(car)

        return
    }


    // Validate gallery files
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
