package car.rental

import grails.gorm.transactions.Rollback
import grails.testing.mixin.integration.Integration
import spock.lang.Specification

@Integration
@Rollback
class PricingServiceSpec extends Specification {

    PricingService pricingService

    CarCategory category
    Car car

    void 'uses the base price when no pricing rule applies'() {

        given:
        setupData()

        expect:
        pricingService.calculateDailyPrice(
                car,
                day('2035-09-01')
        ) == 100.00G

        and:
        pricingService.calculateRentalPrice(
                car,
                day('2035-09-01'),
                day('2035-09-03')
        ) == 300.00G
    }


    void 'applies an all-cars increase rule'() {

        given:
        setupData()

        and:
        createRule(
                name: 'All Cars Increase',
                scope: 'ALL',
                adjustmentType: 'INCREASE',
                percentage: 20.00G,
                priority: 10
        )

        expect:
        pricingService.calculateDailyPrice(
                car,
                day('2035-09-02')
        ) == 120.00G
    }


    void 'applies a category discount rule'() {

        given:
        setupData()

        and:
        createRule(
                name: 'Category Discount',
                scope: 'CATEGORY',
                category: category,
                adjustmentType: 'DISCOUNT',
                percentage: 15.00G,
                priority: 10
        )

        expect:
        pricingService.calculateDailyPrice(
                car,
                day('2035-09-02')
        ) == 85.00G
    }


    void 'higher priority wins even when another rule is more specific'() {

        given:
        setupData()

        and:
        createRule(
                name: 'High Priority All Rule',
                scope: 'ALL',
                adjustmentType: 'INCREASE',
                percentage: 20.00G,
                priority: 20
        )

        createRule(
                name: 'Lower Priority Car Rule',
                scope: 'CAR',
                car: car,
                adjustmentType: 'DISCOUNT',
                percentage: 50.00G,
                priority: 10
        )

        expect:
        pricingService.calculateDailyPrice(
                car,
                day('2035-09-02')
        ) == 120.00G
    }


    void 'car scope wins when priorities are equal'() {

        given:
        setupData()

        and:
        createRule(
                name: 'Equal Priority All Rule',
                scope: 'ALL',
                adjustmentType: 'INCREASE',
                percentage: 20.00G,
                priority: 10
        )

        createRule(
                name: 'Equal Priority Category Rule',
                scope: 'CATEGORY',
                category: category,
                adjustmentType: 'DISCOUNT',
                percentage: 10.00G,
                priority: 10
        )

        createRule(
                name: 'Equal Priority Car Rule',
                scope: 'CAR',
                car: car,
                adjustmentType: 'INCREASE',
                percentage: 50.00G,
                priority: 10
        )

        expect:
        pricingService.calculateDailyPrice(
                car,
                day('2035-09-02')
        ) == 150.00G
    }


    void 'calculates a rental day by day across a pricing period'() {

        given:
        setupData()

        and:
        createRule(
                name: 'Middle Days Increase',
                scope: 'ALL',
                adjustmentType: 'INCREASE',
                percentage: 20.00G,
                priority: 10,
                startDate: day('2035-09-02'),
                endDate: day('2035-09-03')
        )

        expect:
        pricingService.calculateRentalPrice(
                car,
                day('2035-09-01'),
                day('2035-09-04')
        ) == 440.00G
    }


    void 'ignores inactive pricing rules'() {

        given:
        setupData()

        and:
        createRule(
                name: 'Inactive Increase',
                scope: 'ALL',
                adjustmentType: 'INCREASE',
                percentage: 50.00G,
                priority: 100,
                active: false
        )

        expect:
        pricingService.calculateDailyPrice(
                car,
                day('2035-09-02')
        ) == 100.00G
    }


    private void setupData() {

        String uniqueValue =
                UUID.randomUUID()
                        .toString()
                        .replace('-', '')
                        .take(12)

        category =
                new CarCategory(
                        name: "Test-${uniqueValue}"
                ).save(
                        flush: true,
                        failOnError: true
                )

        car =
                new Car(
                        brand: 'Test Brand',
                        model: 'Test Model',
                        year: 2026,
                        plateNumber: "TEST-${uniqueValue}",
                        pricePerDay: 100.00G,
                        status: 'AVAILABLE',
                        category: category
                ).save(
                        flush: true,
                        failOnError: true
                )
    }


    private PricingRule createRule(Map values) {

        new PricingRule(
                name: values.name,
                startDate:
                        values.startDate ?:
                                day('2035-09-01'),
                endDate:
                        values.endDate ?:
                                day('2035-09-05'),
                adjustmentType:
                        values.adjustmentType,
                percentage:
                        values.percentage,
                scope:
                        values.scope,
                category:
                        values.category,
                car:
                        values.car,
                priority:
                        values.priority ?: 0,
                active:
                        values.containsKey('active') ?
                                values.active :
                                true
        ).save(
                flush: true,
                failOnError: true
        )
    }


    private java.sql.Date day(String value) {
        java.sql.Date.valueOf(value)
    }
}
