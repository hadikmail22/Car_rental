package car.rental

import grails.gorm.transactions.Rollback
import grails.testing.mixin.integration.Integration
import spock.lang.Specification

import java.time.LocalDate

@Integration
@Rollback
class RentalDynamicPricingSpec extends Specification {

    RentalService rentalService
    PricingService pricingService

    void 'createRental stores the dynamic price and keeps it locked'() {

        given:
        String uniqueValue =
                UUID.randomUUID()
                        .toString()
                        .replace('-', '')
                        .take(12)

        CarCategory category =
                new CarCategory(
                        name: "Rental-Test-${uniqueValue}"
                ).save(
                        flush: true,
                        failOnError: true
                )

        Car car =
                new Car(
                        brand: 'Test Brand',
                        model: 'Test Model',
                        year: 2026,
                        plateNumber: "RENT-${uniqueValue}",
                        pricePerDay: 100.00G,
                        status: 'AVAILABLE',
                        category: category
                ).save(
                        flush: true,
                        failOnError: true
                )

        User customer =
                new User(
                        username: "rental-${uniqueValue}@example.com",
                        password: 'TestPassword123!',
                        fullName: 'Rental Test Customer'
                ).save(
                        flush: true,
                        failOnError: true
                )

        LocalDate firstDay =
                LocalDate.now().plusYears(2)

        Date startDate = day(firstDay)
        Date endDate = day(firstDay.plusDays(3))

        PricingRule rule =
                new PricingRule(
                        name: "Car Increase ${uniqueValue}",
                        startDate: day(firstDay.plusDays(1)),
                        endDate: day(firstDay.plusDays(2)),
                        adjustmentType: 'INCREASE',
                        percentage: 20.00G,
                        scope: 'CAR',
                        car: car,
                        priority: 50,
                        active: true
                ).save(
                        flush: true,
                        failOnError: true
                )

        when:
        Rental rental =
                rentalService.createRental(
                        customer,
                        car.id,
                        startDate,
                        endDate
                )

        then:
        rental.id
        rental.status == 'PENDING'
        !rental.depositPaid
        rental.totalPrice == 440.00G

        when:
        rule.percentage = 50.00G
        rule.save(
                flush: true,
                failOnError: true
        )

        BigDecimal newQuote =
                pricingService.calculateRentalPrice(
                        car,
                        startDate,
                        endDate
                )

        rental.refresh()

        then:
        newQuote == 500.00G
        rental.totalPrice == 440.00G
    }

    private java.sql.Date day(LocalDate value) {
        java.sql.Date.valueOf(value)
    }
}
