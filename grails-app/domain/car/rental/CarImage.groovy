package car.rental

class CarImage {

    Car car

    byte[] imageData
    String contentType
    String caption

    static belongsTo = [
            car: Car
    ]

    static constraints = {

        imageData nullable: false

        contentType nullable: false

        caption nullable: true,
                maxSize: 100
    }

    static mapping = {

        imageData sqlType: 'LONGBLOB'
    }
}