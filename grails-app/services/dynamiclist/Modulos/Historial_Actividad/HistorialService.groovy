package dynamiclist.Modulos.Historial_Actividad

import Colecciones.Autor
import Colecciones.Mangas
import Modulos.Historial_Actividad.HistorialModulos
import Modulos.Historial_Actividad.HistorialAutor
import Modulos.Historial_Actividad.HistorialMangas
import Modulos.Historial_Actividad.HistorialMangasActividad
import grails.transaction.Transactional

import org.springframework.context.MessageSource

@Transactional
class HistorialService {

    static MessageSource messageSource

    def getListFunctionsMangas(Locale defaultLocale) {
        def list = []
        //Cogemos las funciones basicas
        list = getBasicListFunctions(defaultLocale)
        //Agregar mas funciones
        list << [value: messageSource.getMessage("modulos.historial.addTomos.label", null, defaultLocale), key: HistorialMangas.Status.ADD_TOMOS]
        list << [value: messageSource.getMessage("modulos.historial.addSpinOff.label", null, defaultLocale), key: HistorialMangas.Status.ADD_SPIN_OFF]
        list << [value: messageSource.getMessage("modulos.historial.passRegister.label", null, defaultLocale), key: HistorialMangas.Status.PASS_REGISTRADO]
        list << [value: messageSource.getMessage("modulos.historial.deleteSpinOff.label", null, defaultLocale), key: HistorialMangas.Status.DELETE_SPIN_OFF]
        //Devolver la lista
        return list
    }

    def getListFunctionsModulos(Locale defaultLocale) {
        def list = []
        //Agregamos las funciones
        list << [value: messageSource.getMessage("stats.header.title.general.label", null, defaultLocale), key: HistorialModulos.Modulos.ESTADISTICAS]
        list << [value: messageSource.getMessage("modulos.historial.actividad.lable", null, defaultLocale), key: HistorialModulos.Modulos.HISTORIAL_ACTIVIDAD]
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

    private def getBasicListFunctions(Locale defaultLocale){
        def list = []

        list << [value: messageSource.getMessage("modulos.historial.create.label", null, defaultLocale), key: HistorialAutor.Status.CREACION]
        list << [value: messageSource.getMessage("modulos.historial.show.label", null, defaultLocale), key: HistorialAutor.Status.CONSULTA]
        list << [value: messageSource.getMessage("modulos.historial.update.label", null, defaultLocale), key: HistorialAutor.Status.ACTUALIZACION]
        list << [value: messageSource.getMessage("modulos.historial.delete.label", null, defaultLocale), key: HistorialAutor.Status.ELIMINACION]

        return list
    }
}
