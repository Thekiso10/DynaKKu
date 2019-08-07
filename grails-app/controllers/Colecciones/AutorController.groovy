package Colecciones

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AutorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	//Definir el servicio del Autor
	def autorService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Autor.list(params), model:[autorInstanceCount: Autor.count()]
    }

    def show(Autor autorInstance) {
        respond autorInstance
    }

    def create() {
		def listaEstados = []
		//Colocar los estados del Autor
		listaEstados << message(code: "autores.estado.vivo")
		listaEstados << message(code: "autores.estado.muerto")
		
		//Pasar los parametros a la vista
        respond new Autor(params), model:[listaEstados:listaEstados]
    }

    @Transactional
    def save(Autor autorInstance) {
        if (autorInstance == null) {
            notFound()
            return
        }

        if (autorInstance.hasErrors()) {
            respond autorInstance.errors, view:'create'
            return
        }

        autorInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'autor.label', default: 'Autor'), autorInstance.id])
                redirect autorInstance
            }
            '*' { respond autorInstance, [status: CREATED] }
        }
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
