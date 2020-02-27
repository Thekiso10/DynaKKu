package Security

class Role implements Serializable {

	private static final long serialVersionUID = 1

	String id
	String authority

	static constraints = {
		authority blank: false, unique: true
	}

	static mapping = {
		id generator: "uuid", length: 32
		cache true
	}

	Role(String authority) {
		this()
		this.authority = authority
	}

	@Override
	int hashCode() {
		authority?.hashCode() ?: 0
	}

	@Override
	boolean equals(other) {
		is(other) || (other instanceof Role && other.authority == authority)
	}

	@Override
	String toString() {
		authority
	}
}
