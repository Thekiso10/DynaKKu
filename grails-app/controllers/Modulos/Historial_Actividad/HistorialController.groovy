package Modulos.Historial_Actividad

import org.springframework.web.servlet.support.RequestContextUtils

class HistorialController {

    def historialService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def offset = (params.offset? params.offset:0)

        render (view: 'index', model:[])
    }

    def createPDF(){
        Locale defaultLocale = RequestContextUtils.getLocale(request)
        //Obtener la lista de las funciones
        def listaFuncionesMangas  = historialService.getListFunctionsMangas(defaultLocale)
        def listaFuncionesAutores = historialService.getListFunctionsAutores(defaultLocale)
        def listaFuncionesModulos = historialService.getListFunctionsModulos(defaultLocale)

        render(view: 'createPDF', model: [listaFuncionesMangas: listaFuncionesMangas, 
                                          listaFuncionesAutores: listaFuncionesAutores, 
                                          listaFuncionesModulos: listaFuncionesModulos])
    }

    def generateHistorialPDF() {
    }
}
