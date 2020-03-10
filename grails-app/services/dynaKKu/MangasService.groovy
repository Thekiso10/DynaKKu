package dynaKKu

import Colecciones.Mangas
import grails.transaction.Transactional
import grails.util.Holders
import org.apache.commons.validator.GenericValidator

@Transactional
class MangasService {

    def validateForm(params) {
        def error = false
        def mensaje = null
        //Comprobamos bloque 01 - Datos genericos
        if(!params.nombreManga || !params.autor?.id){
            log.error "El campo del nombre del manga o el autor del manga son nullos o vacios"
            error = true
            mensaje = "mangas.error.campoNullo01" //Codigo del error
        }else{
            //Comprobamos bloque 04 - Generos y Demografia
            if(!params.listOfGenders || !params.demografia?.nombre){
                log.error "El campo de los generos o demografia son nullos o vacios"
                error = true
                mensaje = "mangas.error.campoNullo02" //Codigo del error
            }else{
                //Comprobamos bloque 03 - Datos Monetarios
                if(GenericValidator.isInt(params.numTomosMaximos) && GenericValidator.isInt(params.precioTotal) && GenericValidator.isInt(params.numTomosActuales)){
                    if(Integer.parseInt(params.numTomosMaximos) < 0 || Integer.parseInt(params.precioTotal) < 0 || Integer.parseInt(params.numTomosActuales) < 0){
                        log.error "El campo de los Datos Especificos son negativos"
                        error = true
                        mensaje = "mangas.error.monetarios.negativos" //Codigo del error
                    }
                }else{
                    log.error "El campo de los Datos Especificos no son numeros"
                    error = true
                    mensaje = "mangas.error.monetarios.negativos" //Codigo del error
                }
            }
        }

        return [error: error, mensaje: mensaje]
    }

    def validateLogic(params){
        def error = false
        //Validar coerencia de los datos Especificso
        if(params.completado == true){
            params.serieAcabada = true
            params.serieConsecutiva = true
            /*
               Los tomos en propiedad y tomos totales tienen que ser iguales.
               Si no lo son, se le coloca el mismo valor a los tomos en propiedad.
               No puede ser 0 en el precio por tomo
            */
            //Validar que el numero de tomos maximos no sea 0
            if(Integer.parseInt(params.numTomosMaximos) == 0){
                error = true
            }else if(Integer.parseInt(params.numTomosMaximos) != Integer.parseInt(params.numTomosActuales)){
                log.warn "Estan intentando actualizar un manga completado con diferentes numTomosMaximos y numTomosActuales"
                params.numTomosActuales = params.numTomosMaximos
            }
        }else if(params.deseado == true){  //Validar la logica de los datos monetarios
            /*
                No puede haber tomos en propieda
                Puede ser 0 en el precio por tomo
            */
            if(Integer.parseInt(params.numTomosActuales) >= 1){
                log.warn "Estan intentando actualizar un manga deseado con numero de tomos actuales mayor de 0"
                params.numTomosActuales = '0'
            }
        }

        return [params: params, error: error]
    }

    def validateSpecificDates(params){
        def error = false
        def mensaje = null

        if(params?.deseado.equals('on') || params?.deseado == true){
            //Comprobar que solo este marcaco el parametro deseado
            if(params.completado || params.serieConsecutiva || params.serieAcabada){
                log.error "Estan intentando crear un manga deseado con otras caracteristicas especificas"
                error = true
                mensaje = "mangas.error.especificos.deseados.mas" //Codigo del error
            }
        }else{
            //Validar que como minimo tenga mas de 0 en tomos actuales
            if(GenericValidator.isInt(params?.numTomosActuales)){
                if(Integer.parseInt(params?.numTomosActuales) <= 0){
                    log.error "Estan intentando crear un manga con tomos actuales meñores de 0"
                    error = true
                    mensaje = "mangas.error.especificos.tomosActu.menos" //Codigo del error
                }
            }
        }

        return [error: error, mensaje: mensaje]
    }

    def validateMonetaryData(params){
        def error = false
        def mensaje = null

        if(Integer.parseInt(params.numTomosMaximos) < Integer.parseInt(params.numTomosActuales)){
            log.error "Estan intentando crear un manga con mas tomos en propiedad que tomos totales"
            error = true
            mensaje = "mangas.error.monetarios.numTomosActuales.mayor" //Codigo del error
        }


        return [error: error, mensaje: mensaje]
    }

    def validateName(params){
        def error = false
        def mensaje = null

        if(!comprobarNombreDiferente(params.nombreManga)){
            log.error "Estan intentando crear un manga con un nombre ya registrado"
            error = true
            mensaje = "mangas.error.nombre.yaRegistrado" //Codigo del error
        }else{
            if(!comprobarLongitutNombre(params.nombreManga)){
                log.error "Estan intentando crear un manga con un nombre superior al limite"
                error = true
                mensaje = "mangas.error.nombre.largo" //Codigo del error
            }
        }

        return [error: error, mensaje: mensaje]
    }

    /* Funciones internas */

    private comprobarNombreDiferente(def nombre){
        def buscarAutor = Mangas.findWhere(nombreManga: nombre, borrado: false)
        return (!buscarAutor ? true : false)
    }

    private comprobarLongitutNombre(def nombre) {
        return (nombre.length() <= Holders.config.dynaKKu.mangas.longitut.nombreMax ? true : false)
    }
}
