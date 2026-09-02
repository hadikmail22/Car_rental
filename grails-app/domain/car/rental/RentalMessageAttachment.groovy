package car.rental

class RentalMessageAttachment {

    RentalMessage rentalMessage
    byte[] imageData
    String contentType
    String originalFileName
    String sha256
    Date dateCreated

    static belongsTo = [rentalMessage: RentalMessage]

    static constraints = {
        rentalMessage nullable: false
        imageData nullable: false, maxSize: 5 * 1024 * 1024
        contentType blank: false, inList: [
                'image/jpeg',
                'image/png',
                'image/webp'
        ]
        originalFileName blank: false, maxSize: 255
        sha256 blank: false, size: 64..64
        dateCreated nullable: true
    }

    static mapping = {
        imageData sqlType: 'LONGBLOB'
    }
}
