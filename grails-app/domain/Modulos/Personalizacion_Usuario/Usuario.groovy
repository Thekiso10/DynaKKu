package Modulos.Personalizacion_Usuario

import Security.Role
import Security.UserRole

class Usuario implements Serializable {

    private static final long serialVersionUID = 1

    transient springSecurityService
    transient localeResolver

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
    boolean enabled = true
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
        (nombre && apellido ? nombre + " " + apellido : username)
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

    def setLocalLanguage(){
        Locale defaultLocale
        switch (this.idiomaDefault){
            case 'es':
                defaultLocale = new Locale('es')
                break
            case 'ca':
                defaultLocale = new Locale('ca','ES')
                break
            case 'en':
                defaultLocale = new Locale('en','US')
                break
            default:
                defaultLocale = new Locale('es')
                break
        }
        //Cargamos el idioma en la sessión local del navegador del usuario
        localeResolver.defaultLocale = defaultLocale
    }

    protected void encodePassword() {
        password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }

    static transients = ['springSecurityService']

}
