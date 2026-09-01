package car.rental

import grails.gorm.transactions.Transactional

@Transactional
class PricingRuleService {

    PricingRule get(Long id) {
        PricingRule.get(id)
    }

    def list(
            Map paginationParams = [:],
            String scope = null,
            String state = null) {

        PricingRule.createCriteria().list(paginationParams) {

            if (scope in ['ALL', 'CATEGORY', 'CAR']) {
                eq('scope', scope)
            }

            if (state == 'ACTIVE') {
                eq('active', true)
            } else if (state == 'INACTIVE') {
                eq('active', false)
            }

            order('active', 'desc')
            order('priority', 'desc')
            order('startDate', 'desc')
            order('id', 'desc')
        }
    }

    PricingRule save(PricingRule pricingRule) {

        pricingRule.save(
                flush: true,
                failOnError: true
        )

        pricingRule
    }

    PricingRule toggleActive(Long id) {

        PricingRule pricingRule =
                PricingRule.get(id)

        if (!pricingRule) {
            throw new IllegalArgumentException(
                    'Pricing rule not found.'
            )
        }

        pricingRule.active =
                !pricingRule.active

        pricingRule.save(
                flush: true,
                failOnError: true
        )

        pricingRule
    }
}