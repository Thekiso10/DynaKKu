package Modulos.Estadisticas

import grails.plugin.springsecurity.annotation.Secured

class EstadisticasController {

	def estadisticasService

	@Secured (['ROLE_ADMIN', 'ROLE_USER'])
	def index() {
		redirect(action: "general")
	}

	@Secured (['ROLE_ADMIN', 'ROLE_USER'])
	def general() {
		render (view:"general", model:[])
	}

	@Secured (['ROLE_ADMIN', 'ROLE_USER'])
	def statsAutor() {
		def listaValores = []
		//Coger valor maximo de la edad de los Autores
		def edadMax = estadisticasService.getMaxEdadAutor()?.getEdadAutor()
		def edadMin	= estadisticasService.getMinEdadAutor()?.getEdadAutor()
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

	@Secured (['ROLE_ADMIN', 'ROLE_USER'])
	def statsMangas() {
		render (view:"statsMangas", model:[])
	}
}
