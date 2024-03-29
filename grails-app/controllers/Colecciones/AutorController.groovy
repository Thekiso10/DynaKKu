package Colecciones

import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

import java.text.SimpleDateFormat

@Transactional(readOnly = true)
class AutorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	//Definir el servicio del Autor
	def autorService
	def coleccionesService
	def registerHistorialService
	def gestorModulosService

	@Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
		def offset = (params.offset? params.offset:0)
		def autorInstanceList = Autor.findAllByBorrado(false, params)
		def autorPaginacion = Autor.findAllByBorrado(false).size()

		if(params.search){
			log.info "Se ha ejecutado el filtro de Autores"
			if(params.nombre || params.apellido){ //Para que no se de al filtro con los tres campos vacios
				//Ejecutar el createCriteria con los parametros nombre, apellido y edad
				def autorFiltro = Autor.createCriteria() 
				def listaFiltro = autorFiltro.list (max: params.max, offset:offset){ //Para la paginacion
					ilike ("nombre", ("%" + params.nombre.toString() + "%"))
					ilike ("apellido", ("%" + params.apellido.toString() + "%"))
					eq("borrado", false)
				}
				autorInstanceList = listaFiltro
				autorPaginacion = autorInstanceList.totalCount // .totalCount
				
				if(listaFiltro.size() != 0) {
					flash.message = message(code: "default.filter.resultados.label", args:[autorPaginacion, message(code: "layoutMenu.botonesColeccion.autores")])
				}else{
					flash.message = message(code: "default.filter.noResultados.label")
				}
			}
			
		}else if (params.showAll){
			log.info "Se ha ejecutado la limpieza del filtro de Autores"
			//Ejecutar la limpieza de los parametros del filtro
			params.nombre 	= ""
			params.apellido = ""
		}
		
		if(autorInstanceList.size() == 0){
			flash.warn = message(code: "default.list.notSize", args:[message(code: "layoutMenu.botonesColeccion.autores")])
		}

        respond autorInstanceList, model:[autorInstanceCount: autorPaginacion]
    }

	@Secured (['ROLE_ADMIN', 'ROLE_USER'])
	@Transactional
    def show(Autor autorInstance) {
		if(!autorInstance || autorInstance?.borrado){
			flash.message = message(code: "autores.errores.show")
			redirect(action: "index")
			return
		}
		//Registrar la consulta del Autor
		registerHistorialService.registrarAutor(autorInstance, 2)
        respond autorInstance
    }

	@Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def create() {
        respond new Autor(params)
    }

	@Secured (['ROLE_ADMIN', 'ROLE_USER'])
    @Transactional
    def save(Autor autorInstance, params) {
		def validadorForm = autorService.validarForm(params, true)
		//Validar los datos del formulario
        if (validadorForm.error) {
			flash.error = message(code: validadorForm.mensaje)
            redirect(action: "create")
			return
        }
		//Validar la existencia de un autor con el mismo nombre
		if(autorService.isEqualsAuthor(params.nombre, params.apellido)){
			flash.error = message(code: "autores.errores.nombres")
			redirect(action: "create")
			return
		}
		//Validar el campo del nombre y apellido
		def validarNombre = autorService.validateUpdateNames(autorInstance, params.nombre, params.apellido)
		if(!validarNombre.correcto){
			flash.error = message(code: validarNombre.mensaje)
			redirect(action: "create")
			return
		}

		//Si hay foto guardarla en la carpeta configurada
		def imageInstance = null
		def validadorFoto = null
		def file = request.getFile('imagen')
		if(!file.empty){
			validadorFoto = coleccionesService.saveImgWithBBDD(file)
			if (validadorFoto.error) {
				flash.error = message(code: validadorFoto.mensaje)
				redirect(action: "create")
				return
			}

			imageInstance = validadorFoto.imageInstance
			imageInstance.imgAutor = autorInstance
			try{
				if(imageInstance.save(flush: true)){
					autorInstance.imageAutor = imageInstance
				}else{
					log.error("No se ha podido guardar la imagen")
					flash.message = message(code:'autores.errores.img.saveFolder')
					redirect(action: "create")
					return
				}
			}catch(Exception e){
				flash.message = message(code:'autores.errores.img.saveFolder')
				redirect(action: "create")
				return
			}

		}

		//Guardar en base de datos
		try{
			def nombreAutor = autorInstance.nombre + " " + autorInstance.apellido

			autorInstance.fechaInscripcion = new Date()
			autorInstance.ultimaModificacion = new Date()
			autorInstance.fechaNacimento = new SimpleDateFormat("dd/MM/yy").parse(params.fechaDeNacimento)
			autorInstance.difunto = (params.difunto.equals("true")?true:false)
			if(autorInstance.save(flush:true)){
				log.info "Creando entrada en el historial de un nuevo autor"
				flash.message = message(code: "autores.message.save.ok", args: [nombreAutor])
				registerHistorialService.registrarAutor(autorInstance, 0)
			}else{
				if(!file.empty){
					imageInstance?.delete()
				}
				log.error "No se ha podido guardar en base de datos el Autor"
				flash.error = message(code: "autores.errores.save.bbdd")
				redirect(action: "create")
				return
			}
		}catch(Exception e){
			log.error "No se ha podido guardar en base de datos " + e
			flash.error = message(code: "autores.errores.save.bbdd")
			redirect(action: "create")
			return
		}
		
		redirect(action:"show", id:autorInstance.id)
    }

	@Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def edit(Autor autorInstance) {
		//Validar si existe Autor o no esta borrado
		if(!autorInstance || autorInstance?.borrado){
			flash.message = message(code: "autores.errores.show")
			redirect(action: "index")
			return
		}

        respond autorInstance
    }

	@Secured (['ROLE_ADMIN', 'ROLE_USER'])
    @Transactional
    def updateAutor() {
		def autorInstance = Autor.get(params.id)
		//Validar si existe Autor o no esta borrado
		if(!autorInstance || autorInstance?.borrado){
			flash.message = message(code: "autores.errores.show")
			redirect(action: "index")
			return
		}
		def validadorForm = autorService.validarForm(params, true)
		//Comprobar que no ha cambiado la version == problemas de concurrencia
		if (params.version != null) {
			if (autorInstance.version > Integer.parseInt(params.version.toString())) {
				flash.error = message(code: "autores.errores.update.updateExitente")
				redirect(action: "edit", id:autorInstance.id)
				return
			}
		}
		//Validar los datos del formulario
		if (validadorForm.error) {
			flash.error = message(code: validadorForm.mensaje)
			redirect(action: "edit", id:autorInstance.id)
			return
		}
		//Validar el campo del nombre y apellido
		def validarNombre = autorService.validateUpdateNames(autorInstance, params.nombre, params.apellido)
		if(!validarNombre.correcto){
			flash.error = message(code: validarNombre.mensaje)
			redirect(action: "edit", id:autorInstance.id)
			return
		}
		//Condicional para saber como trabajar con las imagenes
		if(params.checkImg){
			if(params.CheckboxImg){ //Tiene foto y la quiere borrar
				//Quitamos la ruta en BBDD
				def imageInstance = autorInstance.imageAutor
				autorInstance.imageAutor = null
				imageInstance.delete()
			}
		}else{ //No tiene foto
			//Si hay foto guardarla en la carpeta configurada
			def imageInstance = null
			def validadorFoto = null
			def file = request.getFile('imagen')
			if(!file.empty){
				validadorFoto = coleccionesService.saveImgWithBBDD(file)
				if (validadorFoto.error) {
					flash.error = message(code: validadorFoto.mensaje)
					redirect(action: "create")
					return
				}

				imageInstance = validadorFoto.imageInstance
				imageInstance.imgAutor = autorInstance
				try{
					if(imageInstance.save(flush: true)){
						autorInstance.imageAutor = imageInstance
					}else{
						log.error("No se ha podido guardar la imagen")
						flash.message = message(code:'autores.errores.img.saveFolder')
						redirect(action: "create")
						return
					}
				}catch(Exception e){
					flash.message = message(code:'autores.errores.img.saveFolder')
					redirect(action: "create")
					return
				}

			}
		}
		//Actualizar el nuevo Autor
		try{
			def nombreAutor = params.nombre + " " + params.apellido

			autorInstance.ultimaModificacion = new Date()
			autorInstance.fechaNacimento = new SimpleDateFormat("dd/MM/yy").parse(params.fechaDeNacimento)
			autorInstance.properties = params //Guardamos los datos restantes
			if(autorInstance.save(flush:true)){
				log.info "Creando entrada en el historial de una actualizacion de un autor"
				flash.message = message(code: "autores.message.update.ok", args: [nombreAutor])
				registerHistorialService.registrarAutor(autorInstance, 1)
			}else{
				log.error "No se ha podido guardar en base de datos el Autor"
				flash.error = message(code: "autores.errores.update.bbdd")
				redirect(action: "edit", id:autorInstance.id)
				return
			}
		}catch(Exception e){
			log.error "No se ha podido guardar en base de datos " + e
			flash.error = message(code: "autores.errores.update.bbdd")
			redirect(action: "edit", id:autorInstance.id)
			return
		}
		
		redirect(action:"show", id:autorInstance.id)
    }

	@Secured (['ROLE_ADMIN', 'ROLE_USER'])
    @Transactional
    def delete(Autor autorInstance) {
        if (autorInstance == null) {
            notFound()
            return
        }
        //Buscar si tiene algun Manga asociado
        if(Mangas.findAllByAutor(autorInstance)){
            flash.error = message(code: "default.error.delete.bbdd")
            redirect(action: "show", id:autorInstance.id)
            return
        }

        try{
			autorInstance.borrado = true
			autorInstance.fechaBorrado = new Date()
			autorInstance.save(flush:true)
			
			log.info "Creando entrada en el historial de una actualizacion de un autor"
			flash.message = message(code: "autores.message.delete.ok", args: [autorInstance.toString()])
			registerHistorialService.registrarAutor(autorInstance, 3)
			
        }catch(Exception e){
			log.error "No se ha podido borrar en base de datos " + e
			flash.error = message(code: "default.error.delete.bbdd")
			redirect(action: "show", id:autorInstance.id)
			return
		}
		
		redirect(action: "index")
    }
	
	/*--------------------- avatar_image -----------------------*/
	/*															*/
	/* 				Renderizar la imagen del Autor				*/
	/*----------------------------------------------------------*/
	@Secured (['ROLE_ADMIN', 'ROLE_USER'])
	def autor_image() {
		
		def autorInstance = Autor.get(params.id)
		def imageInstance = autorInstance.imageAutor
		if (!imageInstance) {
			response.sendError(404)
			return "no photo"
		}

		response.contentType = imageInstance.imageType
		response.contentLength = imageInstance.image.size()
		OutputStream out = response.outputStream
		out.write(imageInstance.image)
		out.close()
	}
}
