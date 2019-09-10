package dynamiclist

import grails.transaction.Transactional

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
		
		def Autor = Autor.findWhere(nombre:nombre, apellido:apellido)
		
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
	//Guardar la foto del Autor
	def saveImage(def foto, def nombre, def apellido) {
		def error = false
		def path = null
		def mensaje = null
		
		File carpeta = new File(grailsApplication.config.dynamicList.autores.rutaImg)
		
		if(!foto.empty && carpeta.exists()){
			def extensiones = FilenameUtils.getExtension(foto.originalFilename)
			
			if(!extensiones.toLowerCase().equals("jpg") && !extensiones.toLowerCase().equals("jpeg") && !extensiones.toLowerCase().equals("png")){
				error = true
				mensaje = "autores.errores.img.formato"
				log.error "Han intentado introducir un formato invalido de imagen [" + extensiones + "]"
			}else{
				try{
					def nombreAuthor = nombre + "_" + apellido
					path = carpeta.getAbsolutePath() + "\\" + nombreAuthor + "." + extensiones
					foto.transferTo(new File(path))
				}catch (Exception e){
					correcto = false
					mensaje = "autores.errores.img.saveFolder"
					log.error e
				}
			}
		}else{
			error = true
			log.error "[Autor] Validar rutas de la foto a fallado."
		}
	
		return [error:error, mensaje:mensaje, path:path]
	}
	//Eliminar la foto del Autor
	def deleteImage(def path){
		def error = false

		try{
			def file = new File(path)
			file.delete()
			log.info "Se ha borrado correctamente la foto"	
		}catch (Exception e){
			error = true
			log.error "No se ha borrado correctamente la foto"
		}
		
		return error
	}
}
