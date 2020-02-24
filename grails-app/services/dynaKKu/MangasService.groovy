package dynaKKu

import Colecciones.Mangas
import grails.transaction.Transactional
import grails.util.Holders

@Transactional
class MangasService {

    def validateForm(params) {
        def error = false
        def mensaje = null
        //Comprobamos bloque 01 - Datos genericos
        if(!params.nombreManga || !params.autor.id){
            log.error "El campo del nombre del manga o el autor del manga son nullos o vacios"
            error = true
            mensaje = "mangas.error.campoNullo01" //Codigo del error
        }else{
            //Comprobamos bloque 04 - Generos y Demografia
            if(!params.listOfGenders || !params.demografia.nombre){
                log.error "El campo de los generos o demografia son nullos o vacios"
                error = true
                mensaje = "mangas.error.campoNullo02" //Codigo del error
            }else{
                //Comprobamos bloque 03 - Datos Monetarios
                if(Integer.parseInt(params.numTomosMaximos) < 0 || Integer.parseInt(params.precioTotal) < 0 || Integer.parseInt(params.numTomosActuales) < 0){
                    log.error "El campo de los Datos Especificos son negativos"
                    error = true
                    mensaje = "mangas.error.monetarios.negativos" //Codigo del error
                }
            }
        }

        return [error: error, mensaje: mensaje]
    }

    def validateSpecificDates(params){
        def error = false
        def mensaje = null

        if(params.deseado){
            //Comprobar que solo este marcaco el parametro deseado
            if(params.completado || params.serieConsecutiva || params.serieAcabada){
                log.error "Estan intentando crear un manga deseado con otras caracteristicas especificas"
                error = true
                mensaje = "mangas.error.especificos.deseados.mas" //Codigo del error
            }
        }else{
            //Validar que como minimo tenga mas de 0 en tomos actuales
            if(Integer.parseInt(params.numTomosActuales) <= 0){
                log.error "Estan intentando crear un manga con tomos actuales meñores de 0"
                error = true
                mensaje = "mangas.error.especificos.tomosActu.menos" //Codigo del error
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
        return (nombre.length() <= Holders.config.dynamicList.mangas.longitut.nombreMax ? true : false)
    }
}
