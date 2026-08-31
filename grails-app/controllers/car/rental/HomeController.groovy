package car.rental

import grails.plugin.springsecurity.annotation.Secured

class HomeController {

    def springSecurityService


    @Secured(['permitAll'])
    def index() {

        /*
         * إذا المستخدم عامل Login
         * نوديه حسب الـRole.
         */
        if (springSecurityService.isLoggedIn()) {

            User currentUser =
                    springSecurityService.currentUser as User

            boolean isAdmin =
                    currentUser.authorities*.authority.contains(
                            'ROLE_ADMIN'
                    )


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
         * آخر 3 سيارات AVAILABLE
         * لعرضهم بالـLanding Page.
         */
        def featuredCars =
                Car.createCriteria().list(
                        max: 3
                ) {

                    eq(
                            'status',
                            'AVAILABLE'
                    )

                    order(
                            'id',
                            'desc'
                    )
                }


        /*
         * أرقام حقيقية من قاعدة البيانات.
         */
        Long totalCars =
                Car.count()

        Long availableCars =
                Car.countByStatus(
                        'AVAILABLE'
                )


        /*
         * البيانات التي سيتم إرسالها إلى
         * home/index.gsp
         */
        [
                totalCars    : totalCars,
                availableCars: availableCars,
                featuredCars : featuredCars
        ]
    }
}