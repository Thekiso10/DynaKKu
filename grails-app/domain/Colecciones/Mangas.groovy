package Colecciones

class Mangas {
	
	String id
	String nombreManga
	String urlImg
	
	boolean completado
	boolean serieAcabada
	boolean serieConsecutiva
	boolean deseado
	
	int numTomosActuales
	int numTomosMaximos
	int precioTotal
	
	Calendar fechaInscripcion
	Calendar ultimaModificacion
	
	Autor autor
	Demografia demografia
	Mangas mangaSpinOff
	
	static constraints = {
		nombreManga	nullable: true, blank: true
		urlImg		nullable: true, blank: true

		completado			nullable: true, blank: true
		serieAcabada		nullable: true, blank: true
		serieConsecutiva	nullable: true, blank: true
		deseado				nullable: true, blank: true

		numTomosActuales	nullable: true, blank: true
		numTomosMaximos		nullable: true, blank: true
		precioTotal			nullable: true, blank: true

		fechaInscripcion	nullable: true, blank: true
		ultimaModificacion	nullable: true, blank: true

		autor			nullable: true, blank: true
		demografia		nullable: true, blank: true
		mangaSpinOff 	nullable: true, blank: true
	}
	
	static mapping = {
		id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable

		completado			defaultValue: '0'
		serieAcabada		defaultValue: '0'
		serieConsecutiva	defaultValue: '0'
		deseado				defaultValue: '0'

	}
}
