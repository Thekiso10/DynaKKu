package dynamiclist.Historial_Actividad

import Colecciones.Autor
import Modulos.Historial_Actividad.HistorialAutor
import grails.transaction.Transactional

@Transactional
class HistorialService {

    def registrarAutor(Autor autor, int accion) {
		//Definimos las diferentes opciones
		def tipoAccion

		switch(accion){
			case 0: 
				tipoAccion = HistorialAutor.Status.CREACION;
				break
			case 1:
				tipoAccion = HistorialAutor.Status.ACTUALIZACION;
				break
			case 2:
				tipoAccion = HistorialAutor.Status.CONSULTA;
				break
			case 3:
				tipoAccion = HistorialAutor.Status.ELIMINACION;
				break
		}
		guardarRegistroAutor(tipoAccion, autor)
    }

	private def guardarRegistroAutor(def tipoAccion, def autor){
		def h = new HistorialAutor(tipoAccion: tipoAccion, fecha:new Date(),mangas:null, autor:autor)

		if(h.save(flush:true)){
			log.info "Se ha creado la entrada de [" + tipoAccion + "] de " + autor.toString() + " correctamente"
		}else{
			log.error "No se ha podido crear la entrada de [" + tipoAccion + "] de " + autor.toString() + " correctamente"
		}
	}
}
