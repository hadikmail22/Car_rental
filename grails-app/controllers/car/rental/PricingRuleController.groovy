package car.rental

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class PricingRuleController {

    PricingRuleService pricingRuleService

    static allowedMethods = [
            save        : 'POST',
            update      : 'PUT',
            toggleActive: 'POST'
    ]

    def index(Integer max) {

        params.max =
                Math.min(max ?: 10, 100)

        params.offset =
                params.int('offset') ?: 0

        String selectedScope =
                normalizedScope(params.scope)

        String selectedState =
                normalizedState(params.state)

        def pricingRuleList =
                pricingRuleService.list(
                        [
                                max   : params.max,
                                offset: params.offset
                        ],
                        selectedScope,
                        selectedState
                )

        [
                pricingRuleList : pricingRuleList,
                pricingRuleCount: pricingRuleList.totalCount,
                selectedScope   : selectedScope,
                selectedState   : selectedState
        ]
    }

    def create() {

        formModel(
                new PricingRule(
                        adjustmentType: 'INCREASE',
                        scope: 'ALL',
                        priority: 0,
                        active: true
                )
        )
    }

    def save() {

        PricingRule pricingRule =
                bindPricingRule(
                        new PricingRule()
                )

        if (!pricingRule.validate()) {

            render view: 'create',
                    model: formModel(pricingRule)

            return
        }

        pricingRuleService.save(pricingRule)

        flash.message =
                'Pricing rule created successfully.'

        redirect action: 'index'
    }

    def edit(Long id) {

        PricingRule pricingRule =
                pricingRuleService.get(id)

        if (!pricingRule) {
            notFound()
            return
        }

        formModel(pricingRule)
    }

    def update(Long id) {

        PricingRule pricingRule =
                pricingRuleService.get(id)

        if (!pricingRule) {
            notFound()
            return
        }

        bindPricingRule(pricingRule)

        if (!pricingRule.validate()) {

            render view: 'edit',
                    model: formModel(pricingRule)

            return
        }

        pricingRuleService.save(pricingRule)

        flash.message =
                'Pricing rule updated successfully.'

        redirect action: 'index'
    }

    def toggleActive(Long id) {

        try {

            PricingRule pricingRule =
                    pricingRuleService.toggleActive(id)

            flash.message =
                    pricingRule.active ?
                            'Pricing rule activated.' :
                            'Pricing rule deactivated.'

        } catch (IllegalArgumentException exception) {

            flash.message =
                    exception.message
        }

        redirect action: 'index'
    }

    private Map formModel(
            PricingRule pricingRule) {

        List<Car> cars =
                Car.createCriteria().list {
                    order('brand', 'asc')
                    order('model', 'asc')
                    order('plateNumber', 'asc')
                }

        [
                pricingRule: pricingRule,

                categoryList: CarCategory.list(
                        sort: 'name',
                        order: 'asc'
                ),

                carOptions: cars.collect { Car car ->
                    [
                            id   : car.id,
                            label:
                                    "${car.brand} ${car.model} — ${car.plateNumber}"
                    ]
                }
        ]
    }

    private PricingRule bindPricingRule(
            PricingRule pricingRule) {

        pricingRule.name =
                params.name
                        ?.toString()
                        ?.trim()

        pricingRule.startDate =
                parseDate(
                        params.startDate
                )

        pricingRule.endDate =
                parseDate(
                        params.endDate
                )

        pricingRule.adjustmentType =
                params.adjustmentType
                        ?.toString()
                        ?.toUpperCase()

        pricingRule.percentage =
                parseDecimal(
                        params.percentage
                )

        pricingRule.scope =
                params.scope
                        ?.toString()
                        ?.toUpperCase()

        pricingRule.priority =
                parseInteger(
                        params.priority
                )

        pricingRule.active =
                params.boolean('active')

        /*
         * Clear both targets first.
         *
         * This prevents an old CATEGORY value from remaining
         * when the Admin changes the scope to CAR or ALL.
         */
        pricingRule.category = null
        pricingRule.car = null

        if (pricingRule.scope == 'CATEGORY') {

            Long categoryId =
                    params.long('categoryId')

            pricingRule.category =
                    categoryId ?
                            CarCategory.get(categoryId) :
                            null
        }

        if (pricingRule.scope == 'CAR') {

            Long carId =
                    params.long('carId')

            pricingRule.car =
                    carId ?
                            Car.get(carId) :
                            null
        }

        pricingRule
    }

    private Date parseDate(Object value) {

        String text =
                value
                        ?.toString()
                        ?.trim()

        if (!text) {
            return null
        }

        try {

            java.sql.Date.valueOf(text)

        } catch (IllegalArgumentException ignored) {

            null
        }
    }

    private BigDecimal parseDecimal(Object value) {

        String text =
                value
                        ?.toString()
                        ?.trim()

        if (!text) {
            return null
        }

        try {

            new BigDecimal(text)

        } catch (NumberFormatException ignored) {

            null
        }
    }

    private Integer parseInteger(Object value) {

        String text =
                value
                        ?.toString()
                        ?.trim()

        if (!text) {
            return null
        }

        try {

            Integer.valueOf(text)

        } catch (NumberFormatException ignored) {

            null
        }
    }

    private String normalizedScope(Object value) {

        String scope =
                value
                        ?.toString()
                        ?.toUpperCase()

        scope in [
                'ALL',
                'CATEGORY',
                'CAR'
        ] ?
                scope :
                null
    }

    private String normalizedState(Object value) {

        String state =
                value
                        ?.toString()
                        ?.toUpperCase()

        state in [
                'ACTIVE',
                'INACTIVE'
        ] ?
                state :
                null
    }

    private void notFound() {

        flash.message =
                'Pricing rule not found.'

        redirect action: 'index'
    }
}