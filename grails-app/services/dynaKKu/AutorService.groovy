package dynaKKu

import Colecciones.Mangas
import grails.transaction.Transactional
import grails.util.Holders
import Colecciones.Autor

import java.text.SimpleDateFormat


@Transactional
class AutorService {
	
	def grailsApplication
	
	//Validar el formulario de Autor
	def validarForm(params, boolean envioFormulario){
		boolean error = false
		def mensaje = null

		//Validar la edad del Autor
		def edad = calcularYears(params.fechaDeNacimento, envioFormulario)
		if(edad <= grailsApplication.config.dynaKKu.autores.edadMin || edad >= grailsApplication.config.dynaKKu.autores.edadMax){
			error = true
			mensaje = "autores.errores.edad"
			log.error "Han intentado introducir una edad no correcta ["+ edad + "]"
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

	def getFullListWithFormat(){
		//Defimimos la lista final
		def finalList = []
		//Cogemos todos los Mangas, excepto los borrados
		def pureList = Autor.findAllByBorrado(false)
		//Formateamos la lista
		pureList.each { autor ->
			finalList << ["nombreAutor": "${autor.toString()}", "genero": autor.genero, "difunto": autor.difunto, "fechaNacimento": autor.fechaNacimento]
		}

		return finalList
	}

	def getSizeAutorWithBorrados(){
		return Autor.findAllByBorrado(false)?.size()
	}

	/* Funciones internas */

	private comprobarLongitutNombre(def nombre, def apellido) {
		def validoNombre = (nombre.length() <= Holders.config.dynaKKu.autores.longitut.nombreMax ? true : false)
		def validoApellido = (apellido.length() <= Holders.config.dynaKKu.autores.longitut.nombreMax ? true : false)

		return (validoNombre && validoApellido ? true : false)
	}

	private calcularYears(def fecha, boolean envioFormulario){
		//Lo iniciamos a -1 por si ocure una exception y no afectar al resto del codigo
		def diff = -1
		//Protegemos este trozo de codigo por si la variable de la fecha no es correcta
		try{
			//Fecha Actual
			Calendar actual = Calendar.getInstance()
			//Hacemos un Calendar a partir de un String
			Calendar antiguo = Calendar.getInstance()
			antiguo.setTime(new SimpleDateFormat((envioFormulario ? 'dd/MM/yy' : 'dd-MM-yy')).parse(fecha))
			//Calculamos la diferencia
			diff = actual.get(Calendar.YEAR) - antiguo.get(Calendar.YEAR)
			//Ajustamos los años
			if(antiguo.get(Calendar.DAY_OF_YEAR) > actual.get(Calendar.DAY_OF_YEAR)){
				diff--
			}
		}catch (Exception e) {
			e.getMessage()
			e.getCause()
		}

		return diff
	}
}
