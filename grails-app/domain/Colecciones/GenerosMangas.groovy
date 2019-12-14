package Colecciones

class GenerosMangas {
	
	Genero genero
	Mangas mangas
	
    static constraints = {
	}
	
	static mapping = {
		id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
	} 
}
