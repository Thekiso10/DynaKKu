package Modulos.Historial_Actividad

class HistorialModulos {
//Tipo de accions para el historial
    enum Modulos {
        ESTADISTICAS, EXPORTACION_LISTADO, LISTADO_PDF, REPOSRTE_PDF, PERSONALIZACION_USUARIO, HISTORIAL_ACTIVIDAD
    }
    //ID Tabla
    String id
    //variables
    Date fecha
    Modulos modulos

    static constraints = {
        modulos nullable: true, blank: true
        fecha  	nullable: true, blank: true
    }

    static mapping = {
        id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
    }
}
