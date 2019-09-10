package dynamiclist

import Colecciones.Autor
import Funcion.Historial
import grails.transaction.Transactional

@Transactional
class HistorialService {

    def registrarAutor(Autor autor, int accion) {
		
		def tipoAccion = null
		def nombre = autor.nombre + " " + autor.apellido
		
		switch(accion){
			case 0: 
				tipoAccion = Historial.Status.CREACION;
				break;
			case 1:
				tipoAccion = Historial.Status.ACTUALIZACION;
				break;
		}
		
		def h = new Historial(tipoAccion: tipoAccion, fecha:new Date(),mangas:null, autor:nombre)
		if(h.save(flush:true)){
			log.info "Se ha creado la entrada de [" + tipoAccion + "] de " + nombre + " correctamente" 		
		}else{
			log.error "No se ha podido crear la entrada de [" + tipoAccion + "] de " + nombre + " correctamente"
		}
    }
	
	def registrarEliminacionAutor(def nombre){
		def tipoAccion = Historial.Status.ELIMINACION;
		def h = new Historial(tipoAccion: tipoAccion, fecha:new Date(),mangas:null, autor:nombre)
		
		if(h.save(flush:true)){
			log.info "Se ha creado la entrada de [" + tipoAccion + "] de " + nombre + " correctamente"
		}else{
			log.error "No se ha podido crear la entrada de [" + tipoAccion + "] de " + nombre + " correctamente"
		}
	}
}
