package Modulos.Gestor_Modulos

class GestorModulos {
    /* Datos basicos */
    String id
    String nombreModulo
    String configModulo
    boolean valorModulo
    /* Configuracion fechas */
    Date ultimaModificacion
    Date fechaCreacion

    static constraints = {
        nombreModulo         nullable: true, blank: true
        configModulo         nullable: true, blank: true
        valorModulo          nullable: true, blank: true
        ultimaModificacion   nullable: true, blank: true
        fechaCreacion        nullable: true, blank: true
    }

    static mapping = {
        id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
    }
}
