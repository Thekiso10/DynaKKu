package Modulos.Historial_Actividad

class HistorialModulos {
//Tipo de accions para el historial
    enum Modulos {
        ESTADISTICAS, EXPORTACION_LISTADO_AUTOR, EXPORTACION_LISTADO_MANGAS, IMPORACION_LISTADO_AUTOR, IMPORACION_LISTADO_MANGAS,
        LISTADO_PDF, HISTORIAL_ACTIVIDAD, HISTORIAL_ACTIVIDAD_PDF, GESTOR_MODULOS
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
