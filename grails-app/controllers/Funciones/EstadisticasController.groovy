package Funciones

class EstadisticasController {

    def general() {
		render (view:"general", model:[])
	}

	def statsAutor() {
		render (view:"statsAutor", model:[])
	}

	def statsMangas() {
		render (view:"statsMangas", model:[])
	}
}
