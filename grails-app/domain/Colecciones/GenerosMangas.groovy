package Colecciones

class GenerosMangas {
	
	Genero genero
	Mangas mangas
	
    static constraints = {
		genero 	nullable: true, blank: false
		mangas 	nullable: true, blank: false
	}
	
	static mapping = {
		//Cuando se ejecute un Create hay que colocar esta linea
		//id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
	} 
}
