package Security

import Modulos.Personalizacion_Usuario.Usuario
import grails.gorm.DetachedCriteria
import groovy.transform.ToString

import org.apache.commons.lang.builder.HashCodeBuilder

@ToString(cache=true, includeNames=true, includePackage=false)
class UserRole implements Serializable {

	private static final long serialVersionUID = 1

	Usuario user
	Role role

	UserRole(Usuario u, Role r) {
		this()
		user = u
		role = r
	}

	@Override
	boolean equals(other) {
		if (!(other instanceof UserRole)) {
			return false
		}

		other.user?.id == user?.id && other.role?.id == role?.id
	}

	@Override
	int hashCode() {
		def builder = new HashCodeBuilder()
		if (user) builder.append(user.id)
		if (role) builder.append(role.id)
		builder.toHashCode()
	}

	static UserRole get(String userId, String roleId) {
		criteriaFor(userId, roleId).get()
	}

	static boolean exists(String userId, String roleId) {
		criteriaFor(userId, roleId).count()
	}

	private static DetachedCriteria criteriaFor(String userId, String roleId) {
		UserRole.where {
			user == Usuario.load(userId) &&
			role == Role.load(roleId)
		}
	}

	static UserRole create(Usuario user, Role role, boolean flush = false) {
		def instance = new UserRole(user, role)
		instance.save(flush: flush, insert: true)
		instance
	}

	static boolean remove(Usuario u, Role r, boolean flush = false) {
		if (u == null || r == null) return false

		int rowCount = UserRole.where { user == u && role == r }.deleteAll()

		if (flush) { UserRole.withSession { it.flush() } }

		rowCount
	}

	static void removeAll(Usuario u, boolean flush = false) {
		if (u == null) return

		UserRole.where { user == u }.deleteAll()

		if (flush) { UserRole.withSession { it.flush() } }
	}

	static void removeAll(Role r, boolean flush = false) {
		if (r == null) return

		UserRole.where { role == r }.deleteAll()

		if (flush) { UserRole.withSession { it.flush() } }
	}

	static constraints = {
		role validator: { Role r, UserRole ur ->
			if (ur.user == null || ur.user.id == null) return
			boolean existing = false
			UserRole.withNewSession {
				existing = UserRole.exists(ur.user.id, r.id)
			}
			if (existing) {
				return 'userRole.exists'
			}
		}
	}

	static mapping = {
		//id composite: ['user', 'role']
		columns {
			role lazy: false
			user lazy: false
		}
		version false
	}
}
