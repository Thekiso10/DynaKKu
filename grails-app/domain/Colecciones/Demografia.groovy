package Colecciones

class Demografia {
	
	String id
	String nombre
	
    static constraints = {
		nombre 	nullable: true, blank: false
    }
	
	static mapping = {
		id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
	}
}
