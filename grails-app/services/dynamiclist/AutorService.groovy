package dynamiclist

import grails.transaction.Transactional
import grails.util.Holders
import org.apache.commons.io.FilenameUtils

import java.io.File
import java.util.logging.Logger;

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
		
		if(!autorInstance.nombre.equals(nombre) || !autorInstance.apellido.equals(apellido)){
			if(isEqualsAuthor(nombre, apellido)){
				log.error "[Autor] Se ha detectado que se queria actualizar los campos nombres con datos ya registrados"
				correcto = false
			}
		}
		
		return correcto
	}
}
