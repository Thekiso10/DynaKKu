package Colecciones

import org.hibernate.validator.constraints.Length;

class Autor {
	
	String id
	String nombre
	String apellido
	String nacionalidad
	String rutaImagen
	String genero //Masculino o Femenido
	
	int edad
	boolean difunto //Hay dos estados: Si, no
	
	Date fechaInscripcion
	Date ultimaModificacion
		
    static constraints = {
    	nombre 			nullable: true, blank: true
		apellido		nullable: true, blank: true
		rutaImagen  	nullable: true, blank: true
		edad			nullable: true, blank: true
		difunto 		nullable: true, blank: true
		nacionalidad	nullable: true, blank: true
		genero			nullable: true, blank: true
		
		fechaInscripcion	nullable: true, blank: true
		ultimaModificacion	nullable: true, blank: true
	}
	
	static mapping = {
		id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
	}
}
