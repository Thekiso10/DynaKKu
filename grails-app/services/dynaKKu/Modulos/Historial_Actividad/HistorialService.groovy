package dynaKKu.Modulos.Historial_Actividad


import Modulos.Historial_Actividad.HistorialModulos
import Modulos.Historial_Actividad.HistorialAutor
import Modulos.Historial_Actividad.HistorialMangas
import beans.HistorialActividadBean
import grails.orm.HibernateCriteriaBuilder
import grails.transaction.Transactional

import org.springframework.context.MessageSource

import java.text.SimpleDateFormat

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
                    historialMangas = getHistorialMangas(params.function, params.startDate, params.endDate)
                }else if (params.tipoHistorial == '1') {
                    params.function = params.functionAutores
                    historialAutores = getHistorialAutores(params.function, params.startDate, params.endDate)
                }else if (params.tipoHistorial == '2') {
                    params.function = params.functionModulos
                    historialModulos = getHistorialModulos(params.function, params.startDate, params.endDate)
                }
            }else{
                //Hay que generar la lista del historial con todas las funciones
                if (params.tipoHistorial == '0') {
                    historialMangas = getHistorialMangas(null, params.startDate, params.endDate)
                }else if (params.tipoHistorial == '1') {
                    historialAutores = getHistorialAutores(null, params.startDate, params.endDate)
                }else if (params.tipoHistorial == '2') {
                    historialModulos = getHistorialModulos(null, params.startDate, params.endDate)
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

    def getAllListHistorial(Locale defaultLocale){
        def listAllHistorial = []
        def tipo = null
        /* Bucle del historial de Mangas */
        tipo = messageSource.getMessage("layoutMenu.botonesColeccion.mangas", null, defaultLocale)
        getHistorialMangas().each { actividad ->
            def accion = messageSource.getMessage("modulos.historial.label.${actividad.tipoAccion}", null, defaultLocale)
            def mensaje = messageSource.getMessage("modulos.historial.pdf.texto.manga.ACCION", [actividad?.mangas?.nombreManga, actividad.fecha] as Object[], defaultLocale)
            // Guardar el Bean
            HistorialActividadBean historialBean = new HistorialActividadBean(type: tipo, accion: accion, message: mensaje, date: actividad.fecha)
            listAllHistorial << historialBean
        }
        /* Bucle del historial de Autores */
        tipo = messageSource.getMessage("layoutMenu.botonesColeccion.autores", null, defaultLocale)
        getHistorialAutores().each { actividad ->
            def accion = messageSource.getMessage("modulos.historial.label.${actividad.tipoAccion}", null, defaultLocale)
            def mensaje = messageSource.getMessage("modulos.historial.pdf.texto.autor.ACCION", [actividad?.autor?.toString(), actividad.fecha] as Object[], defaultLocale)
            // Guardar el Bean
            HistorialActividadBean historialBean = new HistorialActividadBean(type: tipo, accion: accion, message: mensaje, date: actividad.fecha)
            listAllHistorial << historialBean
        }
        /* Bucle del historial de Autores */
        //TODO: Pendiente de integrar

        return listAllHistorial
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
        list << [value: messageSource.getMessage("modulos.estadisticas.title", null, defaultLocale), key: HistorialModulos.Modulos.ESTADISTICAS]
        list << [value: messageSource.getMessage("modulos.historial.lable.HISTORIAL_ACTIVIDAD", null, defaultLocale), key: HistorialModulos.Modulos.HISTORIAL_ACTIVIDAD]
        list << [value: messageSource.getMessage("modulos.exportacionListado.title", null, defaultLocale), key: HistorialModulos.Modulos.EXPORTACION_LISTADO]
        list << [value: messageSource.getMessage("modulos.listadoPDF.title", null, defaultLocale), key: HistorialModulos.Modulos.LISTADO_PDF]
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

    private def getParseDate(def date){
        Date fecha = null
        SimpleDateFormat f = new SimpleDateFormat("dd/MM/yyyy")
        if(date){
            try {
                fecha = f.parse(date)
                fecha = fecha.clearTime()

                int startYear = fecha[Calendar.YEAR]
                if(startYear<100){
                    startYear = 2000 + startYear
                }
                fecha[Calendar.YEAR] = startYear

            } catch(Exception e) {
                log.error e.message
                log.error e.cause
            }
        }

        return fecha
    }

    private def executeCreateCriteriaHistorial(def funcion, def startDate, def endDate, HibernateCriteriaBuilder historial){
        def lista = historial.list {
            // Filtrar por funciones
            if(funcion){
                eq("tipoAccion", funcion)
            }
            // Filtrar por fecha
            if(startDate && endDate){
                between('fecha', startDate, endDate)
            }else if (startDate){
                ge('fecha', startDate)
            }else if (endDate){
                le('fecha', endDate)
            }
            //Ordenar
            order('fecha', 'desc')
        }

        return lista
    }

    private def getHistorialMangas(def funcion, def dataInicio, def dataFinal){
        def startDate = getParseDate(dataInicio)
        def endDate   = getParseDate(dataFinal)
        //Crear el create criteria
        def c = HistorialMangas.createCriteria()
        def lista = executeCreateCriteriaHistorial(HistorialMangas.Status.valueOf(funcion), startDate, endDate, c)

        return lista
    }

    private def getHistorialAutores(def funcion, def dataInicio, def dataFinal){
        def startDate = getParseDate(dataInicio)
        def endDate   = getParseDate(dataFinal)
        //Crear el create criteria
        def c = HistorialAutor.createCriteria()
        def lista = executeCreateCriteriaHistorial(HistorialAutor.Status.valueOf(funcion), startDate, endDate, c)

        return lista
    }

    private def getHistorialModulos(def funcion, def dataInicio, def dataFinal){
        def startDate = getParseDate(dataInicio)
        def endDate   = getParseDate(dataFinal)
        //Crear el create criteria
        def c = HistorialModulos.createCriteria()
        def lista = executeCreateCriteriaHistorial(HistorialModulos.Status.valueOf(funcion), startDate, endDate, c)

        return lista
    }

    private static def getHistorialMangas(){
        return HistorialMangas.findAll().sort{it.fecha}.reverse()
    }

    private static def getHistorialAutores(){
        return HistorialAutor.findAll().sort{it.fecha}.reverse()
    }

    private static def getHistorialModulos(){
        return HistorialModulos.findAll().sort{it.fecha}.reverse()
    }

    private static def getBasicListFunctions(Locale defaultLocale){
        def list = []

        list << [value: messageSource.getMessage("modulos.historial.label.CREACION", null, defaultLocale), key: HistorialAutor.Status.CREACION]
        list << [value: messageSource.getMessage("modulos.historial.label.CONSULTA", null, defaultLocale), key: HistorialAutor.Status.CONSULTA]
        list << [value: messageSource.getMessage("modulos.historial.label.ACTUALIZACION", null, defaultLocale), key: HistorialAutor.Status.ACTUALIZACION]
        list << [value: messageSource.getMessage("modulos.historial.label.ELIMINACION", null, defaultLocale), key: HistorialAutor.Status.ELIMINACION]

        return list
    }

}
