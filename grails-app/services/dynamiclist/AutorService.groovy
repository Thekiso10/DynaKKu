package dynamiclist

import grails.transaction.Transactional

import org.apache.commons.io.FilenameUtils

import java.io.File

import Colecciones.Autor


@Transactional
class AutorService {
	
	def grailsApplication
	
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
	
	def isEqualsAuthor(def nombre, def apellido){
		boolean igual = false
		
		def nombreAutor = Autor.findWhere(nombre:nombre)
		def apellidoAutor = Autor.findWhere(apellido:apellido)
		
		if(nombreAutor || apellidoAutor){
			igual = true
			log.error "[Autor] Se ha detectado un nombre: [" + nombreAutor + "] o un apellido [" + apellidoAutor + "] igualen"
		}
				
		return igual
	}
	
	def saveImage(def foto, def nombre, def apellido) {
		def correcto = true
		File carpeta = new File(grailsApplication.config.dynamicList.autores.rutaImg)
		
		if(!foto.empty && carpeta.exists()){
			def extensiones = FilenameUtils.getExtension(foto.originalFilename)
			
			if(!extensiones.toLowerCase().equals("jpg") && !extensiones.toLowerCase().equals("jpeg") && !extensiones.toLowerCase().equals("png")){
				correcto = false
				mensaje = "autores.errores.img.formato"
				log.error "Han intentado introducir un formato invalido de imagen [" + extensiones + "]"
			}else{
				try{
					def nombreAuthor = nombre + "_" + apellido
					def path = carpeta.getAbsolutePath() + "\\" + nombreAuthor + "." + extensiones
					foto.transferTo(new File(path))
				}catch (Exception e){
					correcto = false
					log.error e
				}
			}
		}else{
			correcto = false
			log.error "[Autor] Validar rutas de la foto a fallado."
		}
	
		return correcto
	}
}
