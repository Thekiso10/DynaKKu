package Colecciones

import org.hibernate.validator.constraints.Length;

class Autor {
	
	String id
	String nombre
	String apellido
	String rutaImagen
	
	int edad
	boolean difunto //Hay tres estados: Si, no o no lo se
	
	Calendar fechaInscripcion
	Calendar ultimaModificacion
		
    static constraints = {
    	nombre 		nullable: true, blank: true
		apellido	nullable: true, blank: true
		rutaImagen  nullable: true, blank: true
		edad		nullable: true, blank: true
		difunto 	nullable: true, blank: true
		
		fechaInscripcion	nullable: true, blank: true
		ultimaModificacion	nullable: true, blank: true
	}
	
	static mapping = {
		id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
	}
}
