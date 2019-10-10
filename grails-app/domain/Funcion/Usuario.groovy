package Funcion

class Usuario {

    String id
    String nombre
    String apellido
    String idiomaDefault

    boolean modoDark

    Date ultimaModificacion


    static constraints = {
        nombre          nullable: true, blank: true
        apellido        nullable: true, blank: true
        idiomaDefault   nullable: true, blank: true
        modoDark        nullable: true, blank: true

        ultimaModificacion	nullable: true, blank: true
    }

    static mapping = {
        id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
    }
}
