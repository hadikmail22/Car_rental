package car.rental

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

class CarApiController {

    CarService carService

    static responseFormats = ['json']

    static allowedMethods = [
            save  : 'POST',
            update: 'PUT',
            delete: 'DELETE'
    ]


    /*
     * GET /api/cars
     *
     * Admin + Customer
     */
    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
    def index() {

        int max =
                Math.min(
                        params.int('max') ?: 10,
                        100
                )

        int offset =
                params.int('offset') ?: 0


        def cars =
                Car.createCriteria().list(
                        max: max,
                        offset: offset
                ) {

                    if (params.q) {

                        or {

                            ilike(
                                    'brand',
                                    "%${params.q}%"
                            )

                            ilike(
                                    'model',
                                    "%${params.q}%"
                            )

                            ilike(
                                    'plateNumber',
                                    "%${params.q}%"
                            )
                        }
                    }


                    if (params.status) {

                        eq(
                                'status',
                                params.status
                        )
                    }


                    order(
                            'id',
                            'desc'
                    )
                }


        def data =
                cars.collect { Car car ->

                    [
                            id         : car.id,
                            brand      : car.brand,
                            model      : car.model,
                            year       : car.year,
                            plateNumber: car.plateNumber,
                            pricePerDay: car.pricePerDay,
                            status     : car.status,
                            imageUrl   : createLink(
                                    controller: 'car',
                                    action: 'image',
                                    id: car.id,
                                    absolute: true
                            )
                    ]
                }


        render(
                [
                        items : data,

                        pagination: [
                                total : cars.totalCount,
                                max   : max,
                                offset: offset
                        ]
                ] as JSON
        )
    }


    /*
     * GET /api/cars/{id}
     */
    @Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
    def show(Long id) {

        Car car =
                carService.get(id)


        if (!car) {

            render(
                    status: 404,
                    text: (
                            [
                                    error: 'Car not found.'
                            ] as JSON
                    )
            )

            return
        }


        render(
                [
                        id         : car.id,
                        brand      : car.brand,
                        model      : car.model,
                        year       : car.year,
                        plateNumber: car.plateNumber,
                        pricePerDay: car.pricePerDay,
                        status     : car.status,
                        imageUrl   : createLink(
                                controller: 'car',
                                action: 'image',
                                id: car.id,
                                absolute: true
                        )
                ] as JSON
        )
    }


    /*
     * POST /api/cars
     *
     * Admin only
     */
    @Secured(['ROLE_ADMIN'])
    def save() {

        def body =
                request.JSON


        Car car =
                new Car(
                        brand:
                                body.brand,

                        model:
                                body.model,

                        year:
                                body.year as Integer,

                        plateNumber:
                                body.plateNumber,

                        pricePerDay:
                                body.pricePerDay as BigDecimal,

                        status:
                                body.status ?: 'AVAILABLE'
                )


        if (!car.validate()) {

            render(
                    status: 422,
                    text: (
                            [
                                    error : 'Validation failed.',
                                    errors:
                                            car.errors.allErrors.collect {
                                                message(
                                                        error: it
                                                )
                                            }
                            ] as JSON
                    )
            )

            return
        }


        carService.save(car)


        response.status = 201

        response.setHeader(
                'Location',
                createLink(
                        controller: 'carApi',
                        action: 'show',
                        id: car.id,
                        absolute: true
                )
        )


        render(
                [
                        message: 'Car created successfully.',
                        id     : car.id
                ] as JSON
        )
    }


    /*
     * PUT /api/cars/{id}
     *
     * Admin only
     */
    @Secured(['ROLE_ADMIN'])
    def update(Long id) {

        Car car =
                carService.get(id)


        if (!car) {

            render(
                    status: 404,
                    text: (
                            [
                                    error: 'Car not found.'
                            ] as JSON
                    )
            )

            return
        }


        def body =
                request.JSON


        if (body.brand != null) {
            car.brand = body.brand
        }

        if (body.model != null) {
            car.model = body.model
        }

        if (body.year != null) {
            car.year = body.year as Integer
        }

        if (body.plateNumber != null) {
            car.plateNumber =
                    body.plateNumber
        }

        if (body.pricePerDay != null) {
            car.pricePerDay =
                    body.pricePerDay as BigDecimal
        }

        if (body.status != null) {
            car.status =
                    body.status
        }


        if (!car.validate()) {

            render(
                    status: 422,
                    text: (
                            [
                                    error : 'Validation failed.',
                                    errors:
                                            car.errors.allErrors.collect {
                                                message(
                                                        error: it
                                                )
                                            }
                            ] as JSON
                    )
            )

            return
        }


        carService.save(car)


        render(
                [
                        message: 'Car updated successfully.',
                        id     : car.id
                ] as JSON
        )
    }


    /*
     * DELETE /api/cars/{id}
     *
     * Admin only
     */
    @Secured(['ROLE_ADMIN'])
    def delete(Long id) {

        Car car =
                carService.get(id)


        if (!car) {

            render(
                    status: 404,
                    text: (
                            [
                                    error: 'Car not found.'
                            ] as JSON
                    )
            )

            return
        }


        try {

            carService.delete(id)

            render(
                    status: 204,
                    text: ''
            )

        } catch (IllegalStateException e) {

            render(
                    status: 409,
                    text: (
                            [
                                    error: e.message
                            ] as JSON
                    )
            )
        }
    }
}
