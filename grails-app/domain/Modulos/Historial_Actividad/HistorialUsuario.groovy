package Modulos.Historial_Actividad

import Modulos.Personalizacion_Usuario.Usuario

class HistorialUsuario {

    enum Status {
        LOGIN
    }

    String id
    Status typeAction
    Date date
    Usuario user

    static constraints = {
        typeAction 	nullable: true, blank: true
        date 	    nullable: true, blank: true
        user       	nullable: true, blank: true
    }

    static mapping = {
        id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
    }
}
