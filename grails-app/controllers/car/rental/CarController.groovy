package car.rental

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.MultipartFile

class CarController {

    CarService carService

    static allowedMethods = [
            save  : 'POST',
            update: 'PUT',
            delete: 'DELETE'
    ]

    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
    def index() {
        params.max = Math.min(params.int('max') ?: 5, 100)
        params.offset = params.int('offset') ?: 0

        def carList = carService.search(
                params.q,
                [
                        max   : params.max,
                        offset: params.offset
                ]
        )

        [
                carList : carList,
                carCount: carList.totalCount,
                q       : params.q
        ]
    }

    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
    def show(Long id) {
        Car car = carService.get(id)

        if (!car) {
            notFound()
            return
        }

        [car: car]
    }

    @Secured(['ROLE_ADMIN'])
    def create() {
        [car: new Car()]
    }

    @Secured(['ROLE_ADMIN'])
    def save(Car car) {

        if (car == null) {
            notFound()
            return
        }

        MultipartFile image = request.getFile('carImage')

        if (image && !image.empty) {

            if (!image.contentType?.startsWith('image/')) {
                flash.message = 'Only image files are allowed.'
                render view: 'create', model: [car: car]
                return
            }

            if (image.size >= 10 * 1024 * 1024) {
                flash.message = 'Car image must be smaller than 10MB.'
                render view: 'create', model: [car: car]
                return
            }

            car.carImage = image.bytes
            car.imageContentType = image.contentType
        }

        if (car.hasErrors()) {
            render view: 'create', model: [car: car]
            return
        }

        carService.save(car)

        flash.message = 'Car created successfully.'

        redirect action: 'show', id: car.id
    }

    @Secured(['ROLE_ADMIN'])
    def edit(Long id) {

        Car car = carService.get(id)

        if (!car) {
            notFound()
            return
        }

        [car: car]
    }

    @Secured(['ROLE_ADMIN'])
    def update(Car car) {

        if (car == null) {
            notFound()
            return
        }

        MultipartFile image = request.getFile('newCarImage')

        if (image && !image.empty) {

            if (!image.contentType?.startsWith('image/')) {
                flash.message = 'Only image files are allowed.'
                render view: 'edit', model: [car: car]
                return
            }

            if (image.size >= 10 * 1024 * 1024) {
                flash.message = 'Car image must be smaller than 10MB.'
                render view: 'edit', model: [car: car]
                return
            }

            car.carImage = image.bytes
            car.imageContentType = image.contentType
        }

        if (car.hasErrors()) {
            render view: 'edit', model: [car: car]
            return
        }

        carService.save(car)

        flash.message = 'Car updated successfully.'

        redirect action: 'show', id: car.id
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

    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
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
}