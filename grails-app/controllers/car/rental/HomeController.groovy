package car.rental

import grails.plugin.springsecurity.annotation.Secured

class HomeController {

    def springSecurityService

    @Secured(['permitAll'])
    def index() {

        /*
         * إذا المستخدم عامل Login
         * ما في داعي نظل نعرضله Landing Page.
         * بنوديه مباشرة حسب Role.
         */
        if (springSecurityService.isLoggedIn()) {

            User currentUser =
                    springSecurityService.currentUser as User

            boolean isAdmin =
                    currentUser.authorities*.authority.contains('ROLE_ADMIN')

            if (isAdmin) {

                redirect(
                        controller: 'dashboard',
                        action: 'index'
                )

            } else {

                redirect(
                        controller: 'car',
                        action: 'index'
                )
            }

            return
        }


        /*
         * أرقام حقيقية من قاعدة البيانات
         * للـLanding Page.
         */
        Long totalCars =
                Car.count()

        Long availableCars =
                Car.countByStatus('AVAILABLE')


        [
                totalCars    : totalCars,
                availableCars: availableCars
        ]
    }
}