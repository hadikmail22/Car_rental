package car.rental

class RentalMessage {

    Rental rental
    User sender
    String body
    String messageType = 'CHAT'
    boolean readByAdmin = false
    boolean readByCustomer = false
    Date dateCreated

    static hasMany = [attachments: RentalMessageAttachment]

    static belongsTo = [rental: Rental]

    static constraints = {
        rental nullable: false
        sender nullable: false
        body nullable: true, blank: true, maxSize: 2000
        messageType blank: false, inList: [
                'CHAT',
                'PICKUP_INSPECTION',
                'RETURN_INSPECTION'
        ]
        dateCreated nullable: true
    }

    static mapping = {
        body type: 'text'
        attachments cascade: 'all-delete-orphan',
                sort: 'id',
                order: 'asc'
    }
}
