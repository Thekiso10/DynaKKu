package Colecciones

class Genero {
	
	String id
	String nombre
	
    static constraints = {
		
    }
	
	static mapping = {
		id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
	}
}