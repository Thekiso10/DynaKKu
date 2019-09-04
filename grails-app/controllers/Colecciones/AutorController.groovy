package Colecciones

import static org.springframework.http.HttpStatus.*
import java.io.ObjectInputStream.ValidationList;
import javassist.bytecode.stackmap.BasicBlock.Catch;
import dynamiclist.AutorService;
import grails.transaction.Transactional
import java.text.SimpleDateFormat


@Transactional(readOnly = true)
class AutorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	//Definir el servicio del Autor
	def autorService
	def historialService
	
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
		def filterAutor = null
		def autorInstanceList = Autor.list(params)
		def autorPaginacion = Autor.count()
		def offset = (params.offset? params.offset:0)
		
		if(params.search){
			log.info "Se ha ejecutado el filtro de Autores"
			if(params.nombre || params.apellido || params.edad){ //Para que no se de al filtro con los tres campos vacios 
				//Ejecutar el createCriteria con los parametros nombre, apellido y edad
				def autorFiltro = Autor.createCriteria() 
				def listaFiltro = autorFiltro.list (max: params.max, offset:offset){ //Para la paginacion
					ilike ("nombre", ("%" + params.nombre + "%"))
					ilike ("apellido", ("%" + params.apellido + "%"))
					if(params.edad){ //Por si el campo viene vacio
						eq ("edad", Integer.parseInt(params.edad))
					}
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
			params.edad 	= ""
		}
		
		if(autorInstanceList.size() == 0){
			flash.warn = message(code: "default.list.notSize", args:[message(code: "layoutMenu.botonesColeccion.autores")])
		}

        respond autorInstanceList, model:[autorInstanceCount: autorPaginacion]
    }

    def show(Autor autorInstance) {
        respond autorInstance
    }

    def create() {
        respond new Autor(params)
    }

    @Transactional
    def save(Autor autorInstance, params) {
		def validadorForm = autorService.validarForm(params)
		def validadorFoto = null
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
		//Si hay foto guardarla en la carpeta configurada 
		def file = request.getFile('imagen')
		if(!file.empty){
			validadorFoto = autorService.saveImage(file, params.nombre, params.apellido)
			if (validadorFoto.error) {
				flash.error = message(code: validadorFoto.mensaje)
				redirect(action: "create")
				return
			}
			autorInstance.rutaImagen = validadorFoto.path
		}
		//Guardar en base de datos
		try{
			def nombreAutor = autorInstance.nombre + " " + autorInstance.apellido
			def date = new Date()
			def sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss")
			
			autorInstance.fechaInscripcion = new Date()
			autorInstance.ultimaModificacion = new Date()
			autorInstance.difunto = (params.difunto.equals("true"))?true:false
			if(autorInstance.save(flush:true)){
				log.info "Creando entrada en el historial de un nuevo autor"
				flash.message = message(code: "autores.message.save.ok", args: [nombreAutor])
				historialService.registrarAutor(autorInstance, 0)
			}else{
				autorService.deleteImage(validadorFoto.path)
			}
		}catch(Exception e){
			log.error "No se ha podido guardar en base de datos " + e
			flash.error = message(code: "autores.errores.save.bbdd")
			redirect(action: "create")
			return
		}
		
		redirect(action:"show", id:autorInstance.id)
    }

    def edit(Autor autorInstance) {
        respond autorInstance
    }

    @Transactional
    def update(Autor autorInstance) {
        if (autorInstance == null) {
            notFound()
            return
        }

        if (autorInstance.hasErrors()) {
            respond autorInstance.errors, view:'edit'
            return
        }

        autorInstance.save(flush:true)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Autor.label', default: 'Autor'), autorInstance.id])
                redirect autorInstance
            }
            '*'{ respond autorInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Autor autorInstance) {

        if (autorInstance == null) {
            notFound()
            return
        }

        autorInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Autor.label', default: 'Autor'), autorInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
	
	/*--------------------- avatar_image -----------------------*/
	/*															*/
	/* 				Renderizar la imagen del Autor				*/
	/*----------------------------------------------------------*/
	def autor_image() {
		
		def autorInstance = Autor.get(params.id)
		
		def rutaImg = autorInstance.rutaImagen
		File file = new File(rutaImg)
		
		if (!file) {
			response.sendError(404)
			return "no photo"
		}
		
		OutputStream out = response.outputStream
		out.write(file.bytes)
		out.close()
	}
	
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'autor.label', default: 'Autor'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
