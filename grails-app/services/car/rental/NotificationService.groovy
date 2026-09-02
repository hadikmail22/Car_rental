package car.rental

import grails.gorm.transactions.Transactional

import java.time.LocalDate
import java.time.ZoneId
import java.time.format.DateTimeFormatter
import java.time.temporal.ChronoUnit

@Transactional(readOnly = true)
class NotificationService {

    private static final DateTimeFormatter DISPLAY_DATE =
            DateTimeFormatter.ofPattern(
                    'dd MMM yyyy',
                    Locale.ENGLISH
            )

    private static final DateTimeFormatter DISPLAY_DATE_TIME =
            DateTimeFormatter.ofPattern(
                    'dd MMM yyyy · HH:mm',
                    Locale.ENGLISH
            )

    List<Map> getNotificationsForUser(User user) {

        if (!user) {
            return []
        }

        boolean isAdmin =
                user.authorities*.authority.contains(
                        'ROLE_ADMIN'
                )

        List<Rental> rentals =
                isAdmin ?
                        Rental.findAllByStatusInList(
                                [
                                        'CONFIRMED',
                                        'PICKED_UP'
                                ],
                                [
                                        sort : 'startDate',
                                        order: 'asc'
                                ]
                        ) :
                        Rental.findAllByCustomerAndStatusInList(
                                user,
                                [
                                        'CONFIRMED',
                                        'PICKED_UP'
                                ],
                                [
                                        sort : 'startDate',
                                        order: 'asc'
                                ]
                        )

        LocalDate today =
                LocalDate.now(
                        ZoneId.systemDefault()
                )

        List<Map> notifications = []

        rentals.each { Rental rental ->

            if (rental.status == 'CONFIRMED') {

                addPickupNotification(
                        notifications,
                        rental,
                        today,
                        isAdmin
                )
            }

            if (rental.status == 'PICKED_UP') {

                addReturnNotification(
                        notifications,
                        rental,
                        today,
                        isAdmin
                )
            }
        }

        addMessageNotifications(
                notifications,
                user,
                isAdmin
        )

        notifications.sort { Map first, Map second ->

            int rankComparison =
                    (second.sortRank as Integer) <=>
                    (first.sortRank as Integer)

            if (rankComparison != 0) {
                return rankComparison
            }

            (second.sortMoment as Long) <=>
                    (first.sortMoment as Long)
        }

        notifications
    }

    private void addMessageNotifications(
            List<Map> notifications,
            User user,
            boolean isAdmin) {

        List<RentalMessage> unreadMessages

        if (isAdmin) {

            unreadMessages =
                    RentalMessage.findAllByReadByAdmin(
                            false,
                            [
                                    sort : 'dateCreated',
                                    order: 'asc'
                            ]
                    ).findAll { RentalMessage message ->
                        !message.sender.authorities*.authority.contains(
                                'ROLE_ADMIN'
                        )
                    }

        } else {

            unreadMessages =
                    RentalMessage.createCriteria().list {

                        eq(
                                'readByCustomer',
                                false
                        )

                        rental {
                            eq(
                                    'customer',
                                    user
                            )
                        }

                        order(
                                'dateCreated',
                                'asc'
                        )
                    } as List<RentalMessage>

            unreadMessages =
                    unreadMessages.findAll {
                        RentalMessage message ->
                            message.sender.id != user.id
                    }
        }

        unreadMessages
                .groupBy { RentalMessage message ->
                    message.rental.id
                }
                .each {
                    Long rentalId,
                    List<RentalMessage> messages ->

                        RentalMessage lastMessage =
                                messages.max {
                                    RentalMessage message ->
                                        message.dateCreated
                                }

                        Rental rental =
                                lastMessage.rental

                        String senderName =
                                lastMessage.sender.fullName ?:
                                        lastMessage.sender.username

                        String carName =
                                "${rental.car.brand} ${rental.car.model}"

                        Integer unreadCount =
                                messages.size()

                        notifications << [
                                rentalId     : rental.id,
                                eventDate    :
                                        toLocalDate(
                                                lastMessage.dateCreated
                                        ).toString(),
                                dateLabel    :
                                        lastMessage.dateCreated
                                                .toInstant()
                                                .atZone(
                                                        ZoneId.systemDefault()
                                                )
                                                .format(
                                                        DISPLAY_DATE_TIME
                                                ),
                                severity     : 'info',
                                icon         :
                                        'bi-chat-square-text-fill',
                                title        :
                                        unreadCount == 1 ?
                                                'New rental message' :
                                                "${unreadCount} new rental messages",
                                message      :
                                        "${senderName} sent a message about ${carName}.",
                                sortRank     : 5,
                                sortMoment   :
                                        lastMessage.dateCreated.time,
                                messageUnreadCount:
                                        unreadCount,
                                linkController:
                                        'rentalChat',
                                linkAction   : 'show',
                                linkId       : rental.id
                        ]
                }
    }

    private void addPickupNotification(
            List<Map> notifications,
            Rental rental,
            LocalDate today,
            boolean isAdmin) {

        LocalDate pickupDate =
                toLocalDate(rental.startDate)

        long daysUntilPickup =
                ChronoUnit.DAYS.between(
                        today,
                        pickupDate
                )

        if (daysUntilPickup > 1 || daysUntilPickup < 0) {
            return
        }

        String carName =
                "${rental.car.brand} ${rental.car.model}"

        String customerName =
                rental.customer.fullName ?:
                        rental.customer.username

        if (daysUntilPickup == 1) {

            notifications << notification(
                    rental,
                    pickupDate,
                    'info',
                    'bi-calendar2-check',
                    isAdmin ?
                            'Vehicle handover tomorrow' :
                            'Your vehicle pickup is tomorrow',
                    isAdmin ?
                            "Hand over ${carName} to ${customerName} tomorrow." :
                            "Your ${carName} pickup appointment is tomorrow.",
                    2
            )

            return
        }

        if (daysUntilPickup == 0) {

            notifications << notification(
                    rental,
                    pickupDate,
                    'warning',
                    'bi-key-fill',
                    isAdmin ?
                            'Vehicle handover due today' :
                            'Your vehicle pickup is today',
                    isAdmin ?
                            "Hand over ${carName} to ${customerName} today." :
                            "Your ${carName} is scheduled for pickup today.",
                    3
            )

            return
        }

    }

    private void addReturnNotification(
            List<Map> notifications,
            Rental rental,
            LocalDate today,
            boolean isAdmin) {

        LocalDate returnDate =
                toLocalDate(rental.endDate)

        long daysUntilReturn =
                ChronoUnit.DAYS.between(
                        today,
                        returnDate
                )

        if (daysUntilReturn > 1 || daysUntilReturn < 0) {
            return
        }

        String carName =
                "${rental.car.brand} ${rental.car.model}"

        String customerName =
                rental.customer.fullName ?:
                        rental.customer.username

        if (daysUntilReturn == 1) {

            notifications << notification(
                    rental,
                    returnDate,
                    'info',
                    'bi-arrow-return-left',
                    isAdmin ?
                            'Vehicle return tomorrow' :
                            'Return your vehicle tomorrow',
                    isAdmin ?
                            "Receive ${carName} from ${customerName} tomorrow." :
                            "Your ${carName} must be returned tomorrow.",
                    2
            )

            return
        }

        if (daysUntilReturn == 0) {

            notifications << notification(
                    rental,
                    returnDate,
                    'warning',
                    'bi-clock-fill',
                    isAdmin ?
                            'Vehicle return due today' :
                            'Return your vehicle today',
                    isAdmin ?
                            "Receive ${carName} from ${customerName} today." :
                            "Your ${carName} must be returned today.",
                    3
            )

            return
        }

    }

    private Map notification(
            Rental rental,
            LocalDate eventDate,
            String severity,
            String icon,
            String title,
            String message,
            Integer sortRank) {

        [
                rentalId : rental.id,
                eventDate: eventDate.toString(),
                dateLabel: eventDate.format(DISPLAY_DATE),
                severity : severity,
                icon     : icon,
                title    : title,
                message  : message,
                sortRank : sortRank,
                sortMoment:
                        eventDate
                                .atStartOfDay(
                                        ZoneId.systemDefault()
                                )
                                .toInstant()
                                .toEpochMilli(),
                linkController: 'rental',
                linkAction: 'index',
                linkId: null
        ]
    }

    private LocalDate toLocalDate(Date date) {

        if (date instanceof java.sql.Date) {
            return ((java.sql.Date) date).toLocalDate()
        }

        date
                .toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDate()
    }
}
