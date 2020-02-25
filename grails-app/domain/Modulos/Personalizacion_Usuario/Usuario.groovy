package Modulos.Personalizacion_Usuario

import Security.Role
import Security.UserRole

class Usuario implements Serializable {

    private static final long serialVersionUID = 1

    transient springSecurityService

    /* Valores basicos */
    String id
    String nombre
    String apellido
    String mail
    String idiomaDefault
    /* Configuración del tema */
    boolean modoDark
    /* Configuracion fechas */
    Date ultimaModificacion
    Date fechaCreacion
    /* Seguredad */
    String username
    String password
    boolean enabled
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired


    static constraints = {
        nombre          nullable: true, blank: true
        apellido        nullable: true, blank: true
        idiomaDefault   nullable: true, blank: true
        modoDark        nullable: true, blank: true
        mail            nullable: true, blank: true

        username 	    blank: false, unique: true
        password 	    blank: false, nullable: false

        ultimaModificacion	nullable: true, blank: true
    }

    static mapping = {
        id          generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
        password 	column: '`password`'
        enabled     defaultValue: '1'
    }

    Usuario(String username, String password) {
        this()
        this.username = username
        this.password = password
    }

    @Override
    int hashCode() {
        username?.hashCode() ?: 0
    }

    @Override
    boolean equals(other) {
        is(other) || (other instanceof Usuario && other.username == username)
    }

    @Override
    String toString() {
        username
    }

    Set<Role> getAuthorities() {
        UserRole.findAllByUser(this)*.role
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
        password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }

    static transients = ['springSecurityService']

}
