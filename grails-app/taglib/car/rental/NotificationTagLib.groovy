package car.rental

class NotificationTagLib {

    static namespace = 'app'

    NotificationService notificationService
    def springSecurityService

    def notificationMenu = { attrs, body ->

        if (!springSecurityService.isLoggedIn()) {
            return
        }

        List<Map> notificationList =
                notificationListForCurrentRequest()

        out << render(
                template: '/notification/menu',
                model: [
                        notificationList : notificationList,
                        notificationCount: notificationList.size()
                ]
        )
    }

    def messageBadge = { attrs, body ->

        if (!springSecurityService.isLoggedIn()) {
            return
        }

        Long unreadMessageCount =
                (notificationListForCurrentRequest().sum {
                    Map notification ->
                        notification.messageUnreadCount ?: 0
                } ?: 0) as Long

        if (unreadMessageCount <= 0) {
            return
        }

        String displayedCount =
                unreadMessageCount > 99 ?
                        '99+' :
                        unreadMessageCount.toString()

        out << '<span class="premium-message-count">' +
                displayedCount +
                '</span>'
    }

    private List<Map> notificationListForCurrentRequest() {

        String cacheKey =
                'car.rental.currentNotificationList'

        List<Map> notificationList =
                request.getAttribute(
                        cacheKey
                )

        if (notificationList != null) {
            return notificationList
        }

        User currentUser =
                springSecurityService.currentUser as User

        notificationList =
                notificationService.getNotificationsForUser(
                        currentUser
                )

        request.setAttribute(
                cacheKey,
                notificationList
        )

        notificationList
    }
}
