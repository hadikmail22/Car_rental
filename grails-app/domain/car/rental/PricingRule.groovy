package car.rental

class PricingRule {

    String name

    Date startDate
    Date endDate

    String adjustmentType
    BigDecimal percentage

    String scope
    CarCategory category
    Car car

    Integer priority = 0
    Boolean active = true

    Date dateCreated
    Date lastUpdated

    static constraints = {

        name blank: false,
             maxSize: 100

        startDate nullable: false

        endDate nullable: false,
                validator: { Date value, PricingRule rule, errors ->

                    if (value &&
                            rule.startDate &&
                            value.before(rule.startDate)) {

                        errors.rejectValue(
                                'endDate',
                                'pricingRule.endDate.beforeStartDate',
                                'End date must be on or after the start date.'
                        )
                    }
                }

        adjustmentType blank: false,
                       inList: [
                               'DISCOUNT',
                               'INCREASE'
                       ]

        percentage nullable: false,
                   min: 0.01G,
                   max: 100.00G,
                   scale: 2

        scope blank: false,
              inList: [
                      'ALL',
                      'CATEGORY',
                      'CAR'
              ],
              validator: { String value, PricingRule rule, errors ->

                  if (value == 'ALL') {

                      if (rule.category) {
                          errors.rejectValue(
                                  'category',
                                  'pricingRule.category.notAllowed',
                                  'Category must be empty for an ALL-cars rule.'
                          )
                      }

                      if (rule.car) {
                          errors.rejectValue(
                                  'car',
                                  'pricingRule.car.notAllowed',
                                  'Car must be empty for an ALL-cars rule.'
                          )
                      }
                  }

                  if (value == 'CATEGORY') {

                      if (!rule.category) {
                          errors.rejectValue(
                                  'category',
                                  'pricingRule.category.required',
                                  'Category is required for a CATEGORY rule.'
                          )
                      }

                      if (rule.car) {
                          errors.rejectValue(
                                  'car',
                                  'pricingRule.car.notAllowed',
                                  'Car must be empty for a CATEGORY rule.'
                          )
                      }
                  }

                  if (value == 'CAR') {

                      if (!rule.car) {
                          errors.rejectValue(
                                  'car',
                                  'pricingRule.car.required',
                                  'Car is required for a CAR rule.'
                          )
                      }

                      if (rule.category) {
                          errors.rejectValue(
                                  'category',
                                  'pricingRule.category.notAllowed',
                                  'Category must be empty for a CAR rule.'
                          )
                      }
                  }
              }

        category nullable: true
        car nullable: true

        priority nullable: false,
                 min: 0

        active nullable: false
    }

    String toString() {
        name
    }
}
