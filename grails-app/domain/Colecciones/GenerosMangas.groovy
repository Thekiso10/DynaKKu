package Colecciones

class GenerosMangas {

	String id
	Genero genero
	Mangas mangas
	
    static constraints = {
		genero 	nullable: true, blank: false
		mangas 	nullable: true, blank: false
	}
	
	static mapping = {
		id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
	} 
}
