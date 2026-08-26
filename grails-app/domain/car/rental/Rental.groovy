package car.rental

class Rental {

    User customer
    Car car

    Date startDate
    Date endDate

    BigDecimal totalPrice
    BigDecimal bookingDeposit = 50.00
    boolean depositPaid = false

    BigDecimal securityDeposit = 200.00
    BigDecimal damageCost = 0.00

    String status = 'PENDING'

    static constraints = {
        customer nullable: false
        car nullable: false

        startDate nullable: false
        endDate nullable: false

        totalPrice nullable: false, min: 0.0
        bookingDeposit nullable: false, min: 0.0
        securityDeposit nullable: false, min: 0.0
        damageCost nullable: false, min: 0.0

        status blank: false, inList: [
            'PENDING',
            'CONFIRMED',
            'PICKED_UP',
            'COMPLETED',
            'CANCELLED'
        ]
    }
}