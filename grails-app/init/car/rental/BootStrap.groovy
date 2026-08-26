package car.rental

import grails.gorm.transactions.Transactional

class BootStrap {

    def init = {
        createSecurityUsers()
    }

    @Transactional
    void createSecurityUsers() {

        Role adminRole = Role.findByAuthority('ROLE_ADMIN') ?:
                new Role(authority: 'ROLE_ADMIN').save(failOnError: true)

        Role customerRole = Role.findByAuthority('ROLE_CUSTOMER') ?:
                new Role(authority: 'ROLE_CUSTOMER').save(failOnError: true)

        User admin = User.findByUsername('admin@cars.com')

        if (!admin) {
            admin = new User(
                    username: 'admin@cars.com',
                    password: 'admin123',
                    fullName: 'System Admin',
                    phone: '0790000000',
                    dateOfBirth: java.sql.Date.valueOf('1990-01-01'),
                    drivingLicenseNumber: 'ADMIN-001',
                    enabled: true
            ).save(failOnError: true)

            UserRole.create(admin, adminRole, true)
        }

        User customer = User.findByUsername('customer@cars.com')

        if (!customer) {
            customer = new User(
                    username: 'customer@cars.com',
                    password: 'customer123',
                    fullName: 'Test Customer',
                    phone: '0791111111',
                    dateOfBirth: java.sql.Date.valueOf('2000-01-01'),
                    drivingLicenseNumber: 'CUST-001',
                    enabled: true
            ).save(failOnError: true)

            UserRole.create(customer, customerRole, true)
        }
    }

    def destroy = {
    }
}