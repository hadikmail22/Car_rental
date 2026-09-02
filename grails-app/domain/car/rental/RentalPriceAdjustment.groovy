package car.rental

class RentalPriceAdjustment {

    Rental rental
    User adjustedBy
    BigDecimal previousPrice
    BigDecimal newPrice
    String reason
    Date dateCreated

    static belongsTo = [rental: Rental]

    static constraints = {
        rental nullable: false
        adjustedBy nullable: false
        previousPrice nullable: false, min: 0.0, scale: 2
        newPrice nullable: false, min: 0.0, scale: 2
        reason blank: false, maxSize: 500
        dateCreated nullable: true
    }

    static mapping = {
        reason type: 'text'
        sort dateCreated: 'desc'
    }
}
