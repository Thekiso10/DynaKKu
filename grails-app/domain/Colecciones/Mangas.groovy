package Colecciones

class Mangas {
	
	String id
	String nombreManga
	String urlImg
	
	boolean completado
	boolean serieAcabada
	boolean serieConsecutiva
	
	int numTomosActuales
	int numTomosMaximos
	int precioTotal
	
	Calendar fechaInscripcion
	Calendar ultimaModificacion
	
	Autor autor
	Demografia demografia
	
	static constraints = {
	
	}
	
	static mapping = {
		id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
	}
}
