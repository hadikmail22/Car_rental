package car.rental

class User implements Serializable {

    private static final long serialVersionUID = 1

    transient springSecurityService

    String username
    String password

    String fullName
    String phone
    Date dateOfBirth
    String drivingLicenseNumber

    boolean enabled = true
    boolean accountExpired = false
    boolean accountLocked = false
    boolean passwordExpired = false

    static hasMany = [rentals: Rental]

    Set<Role> getAuthorities() {
        UserRole.findAllByUser(this)*.role as Set<Role>
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService?.passwordEncoder ?
                springSecurityService.encodePassword(password) :
                password
    }

    static transients = ['springSecurityService']

    static constraints = {
        username blank: false, unique: true, email: true
        password blank: false

        fullName blank: false
        phone nullable: true
        dateOfBirth nullable: true
        drivingLicenseNumber nullable: true, unique: true
    }

    static mapping = {
        password column: '`password`'
        autowire true
    }
}