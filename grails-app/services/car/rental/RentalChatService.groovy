package car.rental

import grails.gorm.transactions.Transactional
import org.springframework.security.access.AccessDeniedException
import org.springframework.web.multipart.MultipartFile

import java.security.MessageDigest

@Transactional
class RentalChatService {

    private static final Integer MAX_PHOTOS = 8
    private static final Long MAX_PHOTO_SIZE = 5L * 1024L * 1024L

    private static final Set<String> CHAT_STATUSES = [
            'CONFIRMED',
            'PICKED_UP',
            'COMPLETED',
            'CANCELLED'
    ] as Set<String>

    private static final Set<String> MESSAGE_TYPES = [
            'CHAT',
            'PICKUP_INSPECTION',
            'RETURN_INSPECTION'
    ] as Set<String>

    List<Map> getConversationsForUser(User user) {

        if (!user) {
            return []
        }

        boolean adminUser =
                isAdmin(user)

        List<Rental> rentals =
                adminUser ?
                        Rental.findAllByStatusInList(
                                CHAT_STATUSES as List,
                                [sort: 'id', order: 'desc']
                        ) :
                        Rental.findAllByCustomerAndStatusInList(
                                user,
                                CHAT_STATUSES as List,
                                [sort: 'id', order: 'desc']
                        )

        rentals =
                rentals.findAll { Rental rental ->
                    adminUser ?
                            !rental.chatArchivedByAdmin :
                            !rental.chatArchivedByCustomer
                }

        List<Map> conversations =
                rentals.collect { Rental rental ->

                    RentalMessage lastMessage =
                            RentalMessage.findByRental(
                                    rental,
                                    [
                                            sort : 'dateCreated',
                                            order: 'desc'
                                    ]
                            )

                    Long messageCount =
                            RentalMessage.countByRental(
                                    rental
                            ) as Long

                    Long photoCount =
                            RentalMessageAttachment
                                    .executeQuery(
                                            'select count(attachment.id) ' +
                                            'from RentalMessageAttachment attachment ' +
                                            'where attachment.rentalMessage.rental = :rental',
                                            [rental: rental]
                                    )
                                    .first() as Long

                    [
                            rental      : rental,
                            lastMessage : lastMessage,
                            messageCount: messageCount,
                            photoCount  : photoCount
                    ]
                }

        conversations.sort { Map first, Map second ->

            Date firstDate =
                    first.lastMessage?.dateCreated as Date

            Date secondDate =
                    second.lastMessage?.dateCreated as Date

            if (firstDate && secondDate) {
                return secondDate <=> firstDate
            }

            if (firstDate) {
                return -1
            }

            if (secondDate) {
                return 1
            }

            (second.rental.id as Long) <=>
                    (first.rental.id as Long)
        }

        conversations
    }

    Rental getAccessibleRental(
            Long rentalId,
            User user) {

        if (!rentalId) {
            throw new IllegalArgumentException(
                    'Rental is required.'
            )
        }

        Rental rental =
                Rental.get(rentalId)

        if (!rental) {
            throw new IllegalArgumentException(
                    'Rental not found.'
            )
        }

        boolean ownsRental =
                rental.customer?.id == user?.id

        if (!isAdmin(user) && !ownsRental) {
            throw new AccessDeniedException(
                    'You cannot access this conversation.'
            )
        }

        if (!CHAT_STATUSES.contains(rental.status)) {
            throw new IllegalStateException(
                    'The conversation opens after the booking is confirmed.'
            )
        }

        rental
    }

    List<RentalMessage> getMessages(
            Long rentalId,
            User user) {

        Rental rental =
                getAccessibleRental(
                        rentalId,
                        user
                )

        listMessages(rental)
    }

    RentalMessage sendMessage(
            Long rentalId,
            User sender,
            String body,
            String requestedType,
            List<MultipartFile> requestedPhotos) {

        Rental rental =
                getAccessibleRental(
                        rentalId,
                        sender
                )

        String normalizedBody =
                body?.trim()

        if (normalizedBody?.size() > 2000) {
            throw new IllegalArgumentException(
                    'The message cannot exceed 2000 characters.'
            )
        }

        List<MultipartFile> photos =
                (requestedPhotos ?: []).findAll {
                    MultipartFile photo ->
                        photo && !photo.empty
                }

        if (!normalizedBody && !photos) {
            throw new IllegalArgumentException(
                    'Write a message or select at least one photo.'
            )
        }

        if (photos.size() > MAX_PHOTOS) {
            throw new IllegalArgumentException(
                    'You can upload a maximum of 8 photos at once.'
            )
        }

        List<Map> validatedPhotos =
                photos.collect { MultipartFile photo ->
                    validatePhoto(photo)
                }

        String messageType =
                MESSAGE_TYPES.contains(requestedType) ?
                        requestedType :
                        'CHAT'

        boolean adminSender =
                isAdmin(sender)

        if (rental.chatArchivedByAdmin ||
                rental.chatArchivedByCustomer) {

            rental.chatArchivedByAdmin = false
            rental.chatArchivedByCustomer = false

            rental.save(
                    failOnError: true
            )
        }

        RentalMessage message =
                new RentalMessage(
                        rental: rental,
                        sender: sender,
                        body: normalizedBody,
                        messageType: messageType,
                        readByAdmin: adminSender,
                        readByCustomer: !adminSender
                )

        message.save(
                failOnError: true
        )

        validatedPhotos.each { Map photo ->

            RentalMessageAttachment attachment =
                    new RentalMessageAttachment(
                            rentalMessage: message,
                            imageData: photo.bytes as byte[],
                            contentType: photo.contentType as String,
                            originalFileName:
                                    photo.originalFileName as String,
                            sha256: photo.sha256 as String
                    )

            attachment.save(
                    failOnError: true
            )

            message.addToAttachments(
                    attachment
            )
        }

        message.save(
                flush: true,
                failOnError: true
        )

        message
    }

    void archiveConversation(
            Long rentalId,
            User user) {

        Rental rental =
                getAccessibleRental(
                        rentalId,
                        user
                )

        if (!(rental.status in [
                'COMPLETED',
                'CANCELLED'
        ])) {
            throw new IllegalStateException(
                    'Only completed or cancelled conversations can be removed.'
            )
        }

        if (isAdmin(user)) {

            rental.chatArchivedByAdmin = true

            RentalMessage.executeUpdate(
                    'update RentalMessage message ' +
                    'set message.readByAdmin = true ' +
                    'where message.rental = :rental',
                    [rental: rental]
            )

        } else {

            rental.chatArchivedByCustomer = true

            RentalMessage.executeUpdate(
                    'update RentalMessage message ' +
                    'set message.readByCustomer = true ' +
                    'where message.rental = :rental',
                    [rental: rental]
            )
        }

        rental.save(
                flush: true,
                failOnError: true
        )
    }

    void markConversationRead(
            Long rentalId,
            User user) {

        Rental rental =
                getAccessibleRental(
                        rentalId,
                        user
                )

        if (isAdmin(user)) {

            RentalMessage.executeUpdate(
                    'update RentalMessage message ' +
                    'set message.readByAdmin = true ' +
                    'where message.rental = :rental ' +
                    'and message.readByAdmin = false',
                    [rental: rental]
            )

            return
        }

        RentalMessage.executeUpdate(
                'update RentalMessage message ' +
                'set message.readByCustomer = true ' +
                'where message.rental = :rental ' +
                'and message.readByCustomer = false',
                [rental: rental]
        )
    }

    RentalMessageAttachment getAccessibleAttachment(
            Long attachmentId,
            User user) {

        RentalMessageAttachment attachment =
                RentalMessageAttachment.get(
                        attachmentId
                )

        if (!attachment) {
            throw new IllegalArgumentException(
                    'Photo not found.'
            )
        }

        getAccessibleRental(
                attachment.rentalMessage.rental.id,
                user
        )

        attachment
    }

    private List<RentalMessage> listMessages(
            Rental rental) {

        RentalMessage.createCriteria().list {
            eq('rental', rental)
            order('dateCreated', 'asc')
            order('id', 'asc')
        } as List<RentalMessage>
    }

    private Map validatePhoto(
            MultipartFile photo) {

        if (photo.size > MAX_PHOTO_SIZE) {
            throw new IllegalArgumentException(
                    'Each photo must be 5MB or smaller.'
            )
        }

        byte[] bytes =
                photo.bytes

        String detectedContentType =
                detectContentType(bytes)

        if (!detectedContentType) {
            throw new IllegalArgumentException(
                    'Only JPEG, PNG and WebP photos are allowed.'
            )
        }

        [
                bytes           : bytes,
                contentType     : detectedContentType,
                originalFileName:
                        safeFileName(
                                photo.originalFilename,
                                detectedContentType
                        ),
                sha256          : sha256(bytes)
        ]
    }

    private String detectContentType(
            byte[] bytes) {

        if (bytes?.length >= 3 &&
                (bytes[0] & 0xff) == 0xff &&
                (bytes[1] & 0xff) == 0xd8 &&
                (bytes[2] & 0xff) == 0xff) {
            return 'image/jpeg'
        }

        if (bytes?.length >= 8 &&
                (bytes[0] & 0xff) == 0x89 &&
                bytes[1] == 0x50 &&
                bytes[2] == 0x4e &&
                bytes[3] == 0x47 &&
                bytes[4] == 0x0d &&
                bytes[5] == 0x0a &&
                bytes[6] == 0x1a &&
                bytes[7] == 0x0a) {
            return 'image/png'
        }

        if (bytes?.length >= 12 &&
                new String(bytes, 0, 4, 'US-ASCII') == 'RIFF' &&
                new String(bytes, 8, 4, 'US-ASCII') == 'WEBP') {
            return 'image/webp'
        }

        null
    }

    private String safeFileName(
            String originalFileName,
            String contentType) {

        String extension =
                contentType == 'image/png' ?
                        '.png' :
                        contentType == 'image/webp' ?
                                '.webp' :
                                '.jpg'

        String suppliedName =
                originalFileName ?:
                        'rental-photo' + extension

        List<String> pathParts =
                suppliedName
                        .replace('\\', '/')
                        .tokenize('/')

        String fileName =
                pathParts ?
                        pathParts.last() :
                        'rental-photo' + extension

        fileName =
                fileName.replaceAll(
                        '[^A-Za-z0-9._-]',
                        '_'
                )

        if (!fileName) {
            fileName = 'rental-photo'
        }

        Integer dotIndex =
                fileName.lastIndexOf('.')

        String baseName =
                dotIndex > 0 ?
                        fileName.substring(0, dotIndex) :
                        fileName

        baseName.take(245) + extension
    }

    private String sha256(
            byte[] bytes) {

        MessageDigest
                .getInstance('SHA-256')
                .digest(bytes)
                .encodeHex()
                .toString()
    }

    private boolean isAdmin(
            User user) {

        user?.authorities*.authority?.contains(
                'ROLE_ADMIN'
        ) ?: false
    }
}
