package Modulos.Historial_Actividad

import Colecciones.Mangas

class HistorialMangas {
    //Tipo de accions para el historial
    enum Status {
        ACTUALIZACION, CREACION, ELIMINACION, CONSULTA, PASS_REGISTRADO, ADD_TOMOS, ADD_SPIN_OFF
    }
    //ID Tabla
    String id
    //variables
    Date fecha
    Status tipoAccion
    //Objectod
    Mangas mangas

    static constraints = {
        tipoAccion 	nullable: true, blank: true
        fecha  		nullable: true, blank: true

        mangas	    nullable: true, blank: true
    }

    static mapping = {
        id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
    }
}
