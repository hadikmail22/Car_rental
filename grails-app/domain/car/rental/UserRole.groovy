package car.rental

class UserRole implements Serializable {

    private static final long serialVersionUID = 1

    User user
    Role role

    static UserRole create(User user, Role role, boolean flush = false) {
        UserRole instance = new UserRole(
                user: user,
                role: role
        )

        instance.save(flush: flush)
        instance
    }

    static boolean remove(User user, Role role) {
        UserRole instance = UserRole.findByUserAndRole(user, role)

        if (instance) {
            instance.delete(flush: true)
            return true
        }

        false
    }

    static constraints = {
        user nullable: false
        role nullable: false
    }

    static mapping = {
        id composite: ['user', 'role']
        version false
    }
}