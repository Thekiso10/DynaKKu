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
        respond Autor.list(params), model:[autorInstanceCount: Autor.count()]
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
			flash.message = message(code: validadorForm.mensaje)
            redirect(action: "create")
			return
        }
		//Validar la existencia de un autor con el mismo nombre
		if(autorService.isEqualsAuthor(params.nombre, params.apellido)){
			flash.message = message(code: "autores.errores.nombres")
			redirect(action: "create")
			return
		}
		//Si hay foto guardarla en la carpeta configurada 
		def file = request.getFile('imagen')
		if(!file.empty){
			validadorFoto = autorService.saveImage(file, params.nombre, params.apellido)
			if (validadorFoto.error) {
				flash.message = message(code: validadorFoto.mensaje)
				redirect(action: "create")
				return
			}
			autorInstance.rutaImagen = validadorFoto.path
		}
		//Guardar en base de datos
		try{
			def date = new Date()
			def sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss")
			
			autorInstance.fechaInscripcion = new Date()
			autorInstance.ultimaModificacion = new Date()
			autorInstance.difunto = (params.difunto.equals("true"))?true:false
			if(autorInstance.save(flush:true)){
				log.info "Creando entrada en el historial de un nuevo autor"
				historialService.registrarAutor(autorInstance, 0)
			}else{
				//TODO: Si hay un error hay que borrar la foto
			}
		}catch(Exception e){
			log.error "No se ha podido guardar en base de datos " + e
			flash.message = message(code: "autores.errores.save.bbdd")
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
