package Funcion

import Colecciones.Autor;
import Colecciones.Mangas;

class Historial {
	//Tipo de accions para el historial
	enum Status {
		ACTUALIZACION, CREACION, ELIMINACION
	}
	
	String id
	Status tipoAccion
	Date fecha
	
	String mangas
	String autor
	
    static constraints = {
		tipoAccion 	nullable: true, blank: true
		fecha  		nullable: true, blank: true
		
		mangas	nullable: true, blank: true
		autor	nullable: true, blank: true
    }
	
	static mapping = {
		id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
	}
}
