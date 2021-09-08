package dynaKKu.Modulos.Historial_Actividad

import Colecciones.Autor
import Colecciones.Mangas
import Modulos.Historial_Actividad.HistorialAutor
import Modulos.Historial_Actividad.HistorialMangas
import Modulos.Historial_Actividad.HistorialMangasActividad
import Modulos.Historial_Actividad.HistorialModulos
import Modulos.Historial_Actividad.HistorialUsuario
import Modulos.Personalizacion_Usuario.Usuario
import grails.transaction.Transactional

@Transactional
class RegisterHistorialService {

	def registrarUser(Usuario user, HistorialUsuario.Status action){
		saveRegisterUser(user, action)
	}

	def registerModule(HistorialModulos.Modulos module){
		if(new HistorialModulos(modulos: module, fecha: new Date()).save(flush: true)){
			log.info "Se ha creado la entrada de [${module} correctamente"
		}else{
			log.error "No se ha creado la entrada de [${module} correctamente"
		}
	}

	def registrarAutor(Autor autor, int accion) {
		//Definimos las diferentes opciones
		def tipoAccion

		switch(accion){
			case 0:
				tipoAccion = HistorialAutor.Status.CREACION
				break
			case 1:
				tipoAccion = HistorialAutor.Status.ACTUALIZACION
				break
			case 2:
				tipoAccion = HistorialAutor.Status.CONSULTA
				break
			case 3:
				tipoAccion = HistorialAutor.Status.ELIMINACION
				break
		}
		guardarRegistroAutor(tipoAccion, autor)
	}

	def registrarMangas(Mangas manga, int accion){
		def tipoAccion
		//Escoger el tipo de accion
		switch (accion){
			case 0:
				tipoAccion = HistorialMangas.Status.CREACION
				break
			case 1:
				tipoAccion = HistorialMangas.Status.CONSULTA
				break
			case 2:
				tipoAccion = HistorialMangas.Status.ELIMINACION
				break
			case 3:
				tipoAccion = HistorialMangas.Status.PASS_REGISTRADO
				break
		}
		//Registrar en el registro
		def historial = guardarRegistroMangas(tipoAccion, manga)
		//Buscar si hay que registrar algun valor
		if(accion == 0){
			guardarRegistroMangasActividad(4, HistorialMangasActividad.Index.NOMBRE, null, manga, historial)
		}
	}

	def registrarMangas(Mangas manga, def params, int accion){
		def tipoAccion
		def tipoActividad
		//Escoger accion
		switch (accion){
			case 0:
				tipoAccion = HistorialMangas.Status.ACTUALIZACION
				break
			case 1:
				tipoAccion = HistorialMangas.Status.ADD_TOMOS
				tipoActividad = HistorialMangasActividad.Index.ADD_VALUE
				break
			case 2:
				tipoAccion = HistorialMangas.Status.ADD_SPIN_OFF
				tipoActividad = HistorialMangasActividad.Index.ADD_VALUE
				break
			case 3:
				tipoAccion = HistorialMangas.Status.DELETE_SPIN_OFF
				tipoActividad = HistorialMangasActividad.Index.DELETE_VALUE
				break
		}
		//Registrar en el registro
		def historial = guardarRegistroMangas(tipoAccion, manga)
		//Buscar si hay que registrar algun valor
		if(accion == 0){
			def listaCanvios = getListValuesDiferents(manga, params)
			if(listaCanvios.size() != 0){
				listaCanvios.each { canvio ->
					guardarRegistroMangasActividad(historial, canvio[0], canvio[1], canvio[2], manga)
				}
			}
		}else{
			guardarRegistroMangasActividad(accion, tipoActividad, params, manga, historial)
		}

	}

	private saveRegisterUser(Usuario user, HistorialUsuario.Status action){
		if(new HistorialUsuario(typeAction: action, user: user, date: new Date()).save(flush: true)){
			log.info "Se ha creado la entrada de [${action}] de ${user?.toString()} correctamente"
		}else {
			log.error "No se ha creado la entrada de [${action}] de ${user?.toString()} correctamente"
		}
	}

	private def guardarRegistroMangasActividad(HistorialMangas historial, def valorAntiguo, def valorNuevo, def tipoAccion, Mangas manga){
		if(new HistorialMangasActividad(puntero: tipoAccion, valorAnterior: valorAntiguo, valorNuevo: valorNuevo, historialManga: historial).save(flush: true)){
			log.info "Se ha creado la entrada de [" + tipoAccion + "] de " + manga.nombreManga + " correctamente"
		}else{
			log.error "No se ha podido crear la entrada de [" + tipoAccion + "] de " + manga.nombreManga + " correctamente"
		}
	}

	private def guardarRegistroMangasActividad(def index, def tipoAccion, def params, Mangas manga, HistorialMangas historial){
		def historialAccion = new HistorialMangasActividad(puntero: tipoAccion, historialManga: historial)
		switch (index){
			case 1:
				historialAccion.valorAnterior = params
				historialAccion.valorNuevo = Integer.toString(manga.numTomosActuales)
				break
			case 2:
				historialAccion.valorNuevo = manga.mangaSpinOff.nombreManga
				break
			case 3:
				historialAccion.valorEliminado = params
				break
			case 4:
				historialAccion.valorNuevo = manga.nombreManga
				break
		}

		if(historialAccion.save(flush: true)){
			log.info "Se ha creado la entrada de [" + tipoAccion + "] de " + manga.nombreManga + " correctamente"
		}else{
			log.error "No se ha podido crear la entrada de [" + tipoAccion + "] de " + manga.nombreManga + " correctamente"
		}
	}

	private def guardarRegistroMangas(def tipoAccion, Mangas manga){
		//Creamos la instancia del historial
		def h = new HistorialMangas(tipoAccion: tipoAccion, fecha: new Date(), mangas: manga)
		//Guardamos y mostramos un menjage
		if(h.save(flush:true)){
			log.info "Se ha creado la entrada de [" + tipoAccion + "] de " + manga.nombreManga + " correctamente"
		}else{
			log.error "No se ha podido crear la entrada de [" + tipoAccion + "] de " + manga.nombreManga + " correctamente"
		}

		return h
	}

	private def guardarRegistroAutor(def tipoAccion, def autor){
		def h = new HistorialAutor(tipoAccion: tipoAccion, fecha:new Date(),mangas:null, autor:autor)

		if(h.save(flush:true)){
			log.info "Se ha creado la entrada de [" + tipoAccion + "] de " + autor.toString() + " correctamente"
		}else{
			log.error "No se ha podido crear la entrada de [" + tipoAccion + "] de " + autor.toString() + " correctamente"
		}
	}

	private def getListValuesDiferents(Mangas manga, Mangas params){
		def list = []
		//Buscar si han cambiado el nombre
		if(manga?.nombreManga != params?.nombreManga){
			list << [params?.nombreManga, manga?.nombreManga, HistorialMangasActividad.Index.NOMBRE]
		}
		//Buscar si han cambiado del Autor
		if(manga?.autor?.id != params?.autor?.id){
			list << [params.autor?.toString(), manga?.autor?.toString(), HistorialMangasActividad.Index.AUTOR]
		}
		//Buscar cambios en los datos monetarios
		if(manga?.numTomosActuales != params?.numTomosActuales){
			list << [Integer.toString(params?.numTomosActuales), Integer.toString(manga?.numTomosActuales), HistorialMangasActividad.Index.TOMOS_ACTU]
		}
		if(manga?.numTomosMaximos != params?.numTomosMaximos){
			list << [Integer.toString(params?.numTomosMaximos), Integer.toString(manga?.numTomosMaximos), HistorialMangasActividad.Index.TOMOS_MAX]
		}
		if(manga?.precioTotal != params?.precioTotal){
			list << [Double.toString(params?.precioTotal), manga?.precioTotal.toString(), HistorialMangasActividad.Index.PRECIO_TOMO]
		}
		//Buscar cambios en los datos especificos
		if(manga?.completado != params?.completado){
			list << [params?.completado, manga?.completado, HistorialMangasActividad.Index.COMPLETADO]
		}
		if(manga?.serieAcabada != params?.serieAcabada){
			list << [params?.serieAcabada, manga?.serieAcabada, HistorialMangasActividad.Index.ACABADA]
		}
		if(manga?.serieConsecutiva != params?.serieConsecutiva){
			list << [params?.serieConsecutiva, manga?.serieConsecutiva, HistorialMangasActividad.Index.CONSECUTIVA]
		}
		if(manga?.deseado != params?.deseado){
			list << [params?.deseado, manga?.deseado, HistorialMangasActividad.Index.DESEADA]
		}
		//Buscar cambios en los generos y demografia
		if (manga?.demografia != params?.demografia){
			list << [params?.demografia, manga?.demografia, HistorialMangasActividad.Index.DEMOGRAFIA]
		}

		return list
	}
}
