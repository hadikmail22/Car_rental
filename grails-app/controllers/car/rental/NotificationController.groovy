package car.rental

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN', 'ROLE_CUSTOMER'])
class NotificationController {

    NotificationService notificationService
    def springSecurityService

    def index() {

        User currentUser =
                springSecurityService.currentUser as User

        List<Map> notificationList =
                notificationService.getNotificationsForUser(
                        currentUser
                )

        [
                notificationList : notificationList,
                notificationCount: notificationList.size()
        ]
    }
}
