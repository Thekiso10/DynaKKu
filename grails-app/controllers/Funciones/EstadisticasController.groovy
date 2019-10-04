package Funciones

class EstadisticasController {

	def estadisticasService

	def index() {
		redirect(action: "general")
	}

    def general() {
		render (view:"general", model:[])
	}

	def statsAutor() {
		def listaValores = []
		//Coger valor maximo de la edad de los Autores
		def edadMax = estadisticasService.getMaxEdadAutor()
		def edadMin	= estadisticasService.getMinEdadAutor()
		listaValores << estadisticasService.getListAutorJoven() //listaValores[0]
		listaValores << estadisticasService.getListAutorMayor() //listaValores[1]
		//Coger Autor con mayor numero de Mangas
		def numMaxAutorMangas
		//Ultimo autor registrado
		def lastAutor = estadisticasService.getLastAutor()
		//porcentajes
		def listaPorcetajes = []
		listaPorcetajes << estadisticasService.getPorAutoresMasculinos()
		listaPorcetajes << estadisticasService.getPorAutoresFemenino()
		listaPorcetajes << estadisticasService.getPorAutoresVivos()
		listaPorcetajes << estadisticasService.getPorAutoresMuertos()
		//Coger numero
		def listaNumeros = []
		listaNumeros << estadisticasService.getNumAutoresMasculinos()
		listaNumeros << estadisticasService.getNumAutoresFemenino()
		listaNumeros << estadisticasService.getNumAutoresVivos()
		listaNumeros << estadisticasService.getNumAutoresMuertos()
		listaNumeros << estadisticasService.getNumAutores()

		render (view:"statsAutor", model:[
		        edadMax: edadMax,
				edadMin: edadMin,
				lastAutor: lastAutor,
				numMaxAutorMangas: numMaxAutorMangas,
				listaValores: listaValores,
				listaPorcetajes: listaPorcetajes,
				listaNumeros: listaNumeros
		])
	}

	def statsMangas() {
		render (view:"statsMangas", model:[])
	}
}
