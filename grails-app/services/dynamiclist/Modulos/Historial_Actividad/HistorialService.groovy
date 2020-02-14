package dynamiclist.Modulos.Historial_Actividad


import Modulos.Historial_Actividad.HistorialModulos
import Modulos.Historial_Actividad.HistorialAutor
import Modulos.Historial_Actividad.HistorialMangas
import grails.transaction.Transactional

import org.springframework.context.MessageSource

@Transactional
class HistorialService {

    static MessageSource messageSource
    //Definir Servicios externos
    def pdfService

    def generateHistorialPDF(params, def imgBanner, def pathDoc){
        //Defimnimos el documento
        def doc
        //Definir la idioma
        Locale defaultLocale
        //Definior las listas
        def historialMangas = null
        def historialAutores = null
        def historialModulos = null
        //Comprovamos los parametros para generar las lista
        if(params.allHistorial){
            //Setear la varibles de todas las funciones a 'true'
            params.allFunction = true
            //Coger todas el historial
            historialMangas = getHistorialMangas()
            historialAutores = getHistorialAutores()
            historialModulos = getHistorialModulos()
        }else{
            if(!params.allFunction){
                if (params.tipoHistorial == '0') {
                    params.function = params.functionMangas
                }else if (params.tipoHistorial == '1') {
                    params.function = params.functionAutores
                }else if (params.tipoHistorial == '2') {
                    params.function = params.functionModulos
                }
            }
        }
        //Setear el idioma
        if(params.selectIdiomas == "es") {
            defaultLocale = new Locale('es')
        }else if (params.selectIdiomas == "cat") {
            defaultLocale = new Locale('ca', 'es')
        }else if (params.selectIdiomas == "en"){
            defaultLocale = new Locale('en', 'us')
        }
        //Llamamos a la funcion de creación del PDF que nos devolvera el PDF
        doc = pdfService.generateHistorialActividadPDF(historialMangas, historialAutores, historialModulos, defaultLocale, imgBanner, pathDoc, params)
        //Devolvemos el PDF
        return doc
    }

    def getListFunctionsMangas(Locale defaultLocale) {
        def list = []
        //Cogemos las funciones basicas
        list = getBasicListFunctions(defaultLocale)
        //Agregar mas funciones
        list << [value: messageSource.getMessage("modulos.historial.label.ADD_TOMOS", null, defaultLocale), key: HistorialMangas.Status.ADD_TOMOS]
        list << [value: messageSource.getMessage("modulos.historial.label.ADD_SPIN_OFF", null, defaultLocale), key: HistorialMangas.Status.ADD_SPIN_OFF]
        list << [value: messageSource.getMessage("modulos.historial.label.PASS_REGISTRADO", null, defaultLocale), key: HistorialMangas.Status.PASS_REGISTRADO]
        list << [value: messageSource.getMessage("modulos.historial.label.DELETE_SPIN_OFF", null, defaultLocale), key: HistorialMangas.Status.DELETE_SPIN_OFF]
        //Devolver la lista
        return list
    }

    def getListFunctionsModulos(Locale defaultLocale) {
        def list = []
        //Agregamos las funciones
        list << [value: messageSource.getMessage("stats.header.title.general.label", null, defaultLocale), key: HistorialModulos.Modulos.ESTADISTICAS]
        list << [value: messageSource.getMessage("modulos.historial.lable.HISTORIAL_ACTIVIDAD", null, defaultLocale), key: HistorialModulos.Modulos.HISTORIAL_ACTIVIDAD]
        list << [value: messageSource.getMessage("modulos.exportacionListado.title", null, defaultLocale), key: HistorialModulos.Modulos.EXPORTACION_LISTADO]
        list << [value: messageSource.getMessage("modulos.listadoPDF.title", null, defaultLocale), key: HistorialModulos.Modulos.LISTADO_PDF]
        list << [value: messageSource.getMessage("modulos.reportes.title", null, defaultLocale), key: HistorialModulos.Modulos.REPOSRTE_PDF]
        //Devolvemos la lista
        return list
    }

    def getListFunctionsAutores(Locale defaultLocale) {
        def list = []
        //Cogemos las funciones basicas
        list = getBasicListFunctions(defaultLocale)
        //Devolver la lista
        return list
    }

    private def getHistorialMangas(def funcion, def dataInicio, def dataFinal){

    }

    private def getHistorialAutores(def funcion, def dataInicio, def dataFinal){

    }

    private def getHistorialModulos(def funcion, def dataInicio, def dataFinal){

    }

    private static def getBasicListFunctions(Locale defaultLocale){
        def list = []

        list << [value: messageSource.getMessage("modulos.historial.label.CREACION", null, defaultLocale), key: HistorialAutor.Status.CREACION]
        list << [value: messageSource.getMessage("modulos.historial.label.CONSULTA", null, defaultLocale), key: HistorialAutor.Status.CONSULTA]
        list << [value: messageSource.getMessage("modulos.historial.label.ACTUALIZACION", null, defaultLocale), key: HistorialAutor.Status.ACTUALIZACION]
        list << [value: messageSource.getMessage("modulos.historial.label.ELIMINACION", null, defaultLocale), key: HistorialAutor.Status.ELIMINACION]

        return list
    }

    private static def getHistorialMangas(){
        return HistorialMangas.findAll()
    }

    private static def getHistorialAutores(){
        return HistorialAutor.findAll()
    }

    private static def getHistorialModulos(){
        return HistorialModulos.findAll()
    }

}
