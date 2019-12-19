package Modulos.Historial_Actividad

import Colecciones.Autor;

class HistorialAutor {
	//Tipo de accions para el historial
	enum Status {
		ACTUALIZACION, CREACION, ELIMINACION, CONSULTA
	}
	
	String id
	Status tipoAccion
	Date fecha
	
	Autor autor

    static constraints = {
		tipoAccion 	nullable: true, blank: true
		fecha  		nullable: true, blank: true
		
		autor	nullable: true, blank: true
    }
	
	static mapping = {
		id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
	}
}
