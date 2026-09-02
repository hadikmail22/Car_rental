package car.rental

import grails.gorm.transactions.Rollback
import grails.testing.mixin.integration.Integration
import spock.lang.Specification

import java.time.LocalDate

@Integration
@Rollback
class RentalPriceAdjustmentSpec extends Specification {

    RentalService rentalService

    void 'admin changes final price without losing the calculated price or audit history'() {

        given:
        String uniqueValue =
                UUID.randomUUID()
                        .toString()
                        .replace('-', '')
                        .take(12)

        Role adminRole =
                Role.findByAuthority('ROLE_ADMIN') ?:
                        new Role(
                                authority: 'ROLE_ADMIN'
                        ).save(
                                flush: true,
                                failOnError: true
                        )

        User admin =
                new User(
                        username: "price-admin-${uniqueValue}@example.com",
                        password: 'TestPassword123!',
                        fullName: 'Price Test Admin'
                ).save(
                        flush: true,
                        failOnError: true
                )

        UserRole.create(
                admin,
                adminRole,
                true
        )

        User customer =
                new User(
                        username: "price-customer-${uniqueValue}@example.com",
                        password: 'TestPassword123!',
                        fullName: 'Price Test Customer'
                ).save(
                        flush: true,
                        failOnError: true
                )

        CarCategory category =
                new CarCategory(
                        name: "Price-Test-${uniqueValue}"
                ).save(
                        flush: true,
                        failOnError: true
                )

        Car car =
                new Car(
                        brand: 'Test Brand',
                        model: 'Test Model',
                        year: 2026,
                        plateNumber: "PRICE-${uniqueValue}",
                        pricePerDay: 100.00G,
                        status: 'AVAILABLE',
                        category: category
                ).save(
                        flush: true,
                        failOnError: true
                )

        LocalDate firstDay =
                LocalDate.now().plusYears(2)

        Rental rental =
                new Rental(
                        customer: customer,
                        car: car,
                        startDate: java.sql.Date.valueOf(firstDay),
                        endDate: java.sql.Date.valueOf(firstDay.plusDays(4)),
                        totalPrice: 500.00G,
                        systemCalculatedPrice: 500.00G,
                        bookingDeposit: 50.00G,
                        depositPaid: true,
                        securityDeposit: 200.00G,
                        damageCost: 0.00G,
                        status: 'CONFIRMED'
                ).save(
                        flush: true,
                        failOnError: true
                )

        when:
        RentalPriceAdjustment adjustment =
                rentalService.adjustRentalPrice(
                        rental.id,
                        375.00G,
                        'Family discount approved by manager',
                        admin
                )

        rental.refresh()

        then:
        rental.totalPrice == 375.00G
        rental.systemCalculatedPrice == 500.00G
        adjustment.previousPrice == 500.00G
        adjustment.newPrice == 375.00G
        adjustment.adjustedBy.id == admin.id
        adjustment.reason == 'Family discount approved by manager'

        when:
        Map<Long, List<RentalPriceAdjustment>> history =
                rentalService.getPriceAdjustmentsByRental([rental])

        then:
        history[rental.id]*.id == [adjustment.id]
    }
}
