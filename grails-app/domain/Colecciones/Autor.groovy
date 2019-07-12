package Colecciones

class Autor {
	
	String id
	String Nombre
	String Apellido
	String RutaImagen
	int edad
	int difunto //Hay tres estados: Si, no o no lo se
	Date fechaInscripcion
	Date UltimaModificacion
	
    static constraints = {
    
	}
	
	static mapping = {
		id generator: 'uuid' //Para generar un id auto-incrementable
	}
}
