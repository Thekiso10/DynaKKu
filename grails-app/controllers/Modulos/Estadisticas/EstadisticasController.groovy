package Modulos.Estadisticas

import Modulos.Gestor_Modulos.GestorModulos
import grails.plugin.springsecurity.annotation.Secured

class EstadisticasController {

	def estadisticasService
	def gestorModulosService

	@Secured (['ROLE_ADMIN', 'ROLE_USER'])
	def index() {
		if(gestorModulosService.validatePermission("dynaKKu.estadisticas.enable")){
			redirect(action: "general")
		}else{
			redirect(controller: "usuario", action: "index")
		}
	}

	@Secured (['ROLE_ADMIN', 'ROLE_USER'])
	def general() {
		if(gestorModulosService.validatePermission("dynaKKu.estadisticas.enable")){
			render (view:"general", model:[])
		}else{
			redirect(controller: "usuario", action: "index")
		}
	}
}
