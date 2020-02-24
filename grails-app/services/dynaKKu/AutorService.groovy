package dynaKKu

import grails.transaction.Transactional
import grails.util.Holders
import Colecciones.Autor


@Transactional
class AutorService {
	
	def grailsApplication
	
	//Validar el formulario de Autor
	def validarForm(params){
		boolean error = false
		def mensaje = null

		if(Integer.parseInt(params.edad) <= grailsApplication.config.dynamicList.autores.edadMin || Integer.parseInt(params.edad) >= grailsApplication.config.dynamicList.autores.edadMax){
			error = true
			mensaje = "autores.errores.edad"
			log.error "Han intentado introducir una edad no correcta ["+ params.edad + "]"
		}
		
		if(!params.nacionalidad || !params.nombre || !params.apellido){
			error = true
			mensaje = "autores.errores.campo.vacia"
			log.error "Han intentado introducir un campo vacio"
		}
		
		return [error:error, mensaje:mensaje]
	}
	//Comprobar que no exista un Autor con el mismo nombre
	def isEqualsAuthor(def nombre, def apellido){
		boolean igual = false
		
		def Autor = Autor.findWhere(nombre:nombre, apellido:apellido, borrado: false)
		
		if(Autor){
			igual = true
			log.error "[Autor] Se ha detectado un nombre: [" + Autor.nombre + " " + Autor.apellido + "] igual"
		}
				
		return igual
	}
	//Comprobar si ha habido un cambio de nombre y si es correcto
	def validateUpdateNames(Autor autorInstance, def nombre, def apellido){
		boolean correcto = true
		String mensaje = null
		
		if(!autorInstance.nombre.equals(nombre) || !autorInstance.apellido.equals(apellido)){
			// Validar si ya existe esta combinacion
			if(isEqualsAuthor(nombre, apellido)){
				log.error "[Autor] Se ha detectado que se queria actualizar los campos nombres con datos ya registrados"
				correcto = false
				mensaje = "autores.errores.update.nombresExistentes"
			}
		}
		//Comprobar la longitut
		if(!comprobarLongitutNombre(nombre, apellido)){
			log.error "[Autor] Se ha detectado que se queria actualizar los campos nombres con longitut incorrecta"
			correcto = false
			mensaje = "autores.errores.nombres.largo"
		}
		
		return [correcto: correcto, mensaje: mensaje]
	}

	/* Funciones internas */

	private comprobarLongitutNombre(def nombre, def apellido) {
		def validoNombre = (nombre.length() <= Holders.config.dynamicList.autores.longitut.nombreMax ? true : false)
		def validoApellido = (apellido.length() <= Holders.config.dynamicList.autores.longitut.nombreMax ? true : false)

		return (validoNombre && validoApellido ? true : false)
	}
}
