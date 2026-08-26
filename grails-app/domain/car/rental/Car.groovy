package car.rental

class Car {

    String brand
    String model
    Integer year
    String plateNumber
    BigDecimal pricePerDay
    String status = 'AVAILABLE'

    byte[] carImage
    String imageContentType

    static hasMany = [rentals: Rental]

    static constraints = {
        brand blank: false
        model blank: false
        year nullable: false, min: 1900
        plateNumber blank: false, unique: true
        pricePerDay nullable: false, min: 0.0

        status blank: false, inList: [
                'AVAILABLE',
                'RENTED',
                'MAINTENANCE'
        ]

        carImage nullable: true
        imageContentType nullable: true
    }

    static mapping = {
        carImage sqlType: 'LONGBLOB'
    }
}