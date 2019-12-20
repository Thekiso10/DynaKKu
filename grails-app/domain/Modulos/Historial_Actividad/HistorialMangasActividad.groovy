package Modulos.Historial_Actividad

class HistorialMangasActividad {
    //Tipo de accions para el historial
    enum Index {
        DELETE_VALUE, ADD_VALUE, NOMBRE, AUTOR, COMPLETADO, ACABADA, CONSECUTIVA, DESEADA, TOMOS_ACTU, TOMOS_MAX, PRECIO_TOMO, GENERO, DEMOGRAFIA
    }
    //ID Tabla
    String id
    //variables
    String valorAnterior
    String valorNuevo
    String valorEliminado
    Index puntero
    //Objectos
    HistorialMangas historialManga

    static constraints = {
        valorAnterior 	nullable: true, blank: true
        valorNuevo  	nullable: true, blank: true
        valorEliminado 	nullable: true, blank: true
        puntero  		    nullable: true, blank: true

        historialManga	nullable: true, blank: true
    }

    static mapping = {
        id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
    }
}
