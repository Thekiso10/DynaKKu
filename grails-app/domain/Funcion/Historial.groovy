package Funcion

class Historial {
	//Tipo de accions para el historial
	enum Status {
		Actualizaion, Creacion, Eliminacion
	}
	
	String id
	Status tipoAccion
	String accion
	Calendar fecha
	
    static constraints = {
    }
	
	static mapping = {
		id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
		
		tablePerHierarchy: false
	}
}
