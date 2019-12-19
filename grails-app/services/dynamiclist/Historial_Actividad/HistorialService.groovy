package dynamiclist.Historial_Actividad

import Colecciones.Autor
import Modulos.Historial_Actividad.Historial
import grails.transaction.Transactional

@Transactional
class HistorialService {

    def registrarAutor(Autor autor, int accion) {
		
		def tipoAccion
		def nombre = autor.nombre + " " + autor.apellido
		
		switch(accion){
			case 0: 
				tipoAccion = Historial.Status.CREACION;
				break;
			case 1:
				tipoAccion = Historial.Status.ACTUALIZACION;
				break;
			case 2:
				tipoAccion = Historial.Status.CONSULTA;
				break;
		}
		guardarRegistroAutor(tipoAccion, nombre)
    }
	
	def registrarEliminacionAutor(def nombre){
		def tipoAccion = Historial.Status.ELIMINACION;
		guardarRegistroAutor(tipoAccion, nombre)
	}

	def guardarRegistroAutor(def tipoAccion, def nombre){
		def h = new Historial(tipoAccion: tipoAccion, fecha:new Date(),mangas:null, autor:nombre)

		if(h.save(flush:true)){
			log.info "Se ha creado la entrada de [" + tipoAccion + "] de " + nombre + " correctamente"
		}else{
			log.error "No se ha podido crear la entrada de [" + tipoAccion + "] de " + nombre + " correctamente"
		}
	}
}
