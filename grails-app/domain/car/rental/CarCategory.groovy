package car.rental

class CarCategory {

    String name

    static hasMany = [
        cars: Car
    ]

    static mappedBy = [
        cars: 'category'
    ]

    static constraints = {
        name blank: false,
             unique: true,
             maxSize: 50
    }

    String toString() {
        name
    }
}