package Colecciones

import org.hibernate.validator.constraints.Length

import java.text.SimpleDateFormat;

class Autor {
	
	String id
	String nombre
	String apellido
	String nacionalidad
	String genero //Masculino o Femenino

	Image imageAutor

	boolean difunto //Hay dos estados: Si, no
	boolean borrado //Marca si esta borrado o no

	Date fechaNacimento
	Date fechaInscripcion
	Date ultimaModificacion
	Date fechaBorrado
		
    static constraints = {
    	nombre 			nullable: true, blank: true
		apellido		nullable: true, blank: true
		imageAutor  	nullable: true, blank: true
		fechaNacimento	nullable: true, blank: true
		difunto 		nullable: true, blank: true
		nacionalidad	nullable: true, blank: true
		genero			nullable: true, blank: true
		borrado			nullable: true, blank: true
		
		fechaInscripcion	nullable: true, blank: true
		ultimaModificacion	nullable: true, blank: true
		fechaBorrado		nullable: true, blank: true
	}
	
	static mapping = {
		id generator: 'uuid', Length: 32 //Para generar un id auto-incrementable
		//valores por defecto
		borrado  defaultValue: '0'
	}

	@Override
	String toString(){
		return nombre + " " + apellido
	}

	def getEdadAutor(){
		//Fecha Actual
		Calendar actual = Calendar.getInstance()
		//Hacemos un Calendar a partir de un String
		Calendar antiguo = Calendar.getInstance()
		antiguo.setTime(this.fechaNacimento)
		//Calculamos la diferencia
		def diff = actual.get(Calendar.YEAR) - antiguo.get(Calendar.YEAR)
		//Ajustamos los años
		if(antiguo.get(Calendar.DAY_OF_YEAR) > actual.get(Calendar.DAY_OF_YEAR)){
			diff--
		}

		return diff
	}
}
