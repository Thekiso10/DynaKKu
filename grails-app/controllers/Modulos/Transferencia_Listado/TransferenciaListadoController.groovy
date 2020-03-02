package Modulos.Transferencia_Listado

import Colecciones.Autor
import grails.plugin.springsecurity.annotation.Secured

class TransferenciaListadoController {

    def transferenciaListadoService

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def ExportAutores() {
        def listaAtributos = grailsApplication.config.dynaKKu.transferenciaListado.autores.atributos
        def listaAutores = Autor.findAll()

        if(!listaAutores && listaAutores?.size() <= 0){
            log.error "Han intentado generar la exportación de Autores sin ningun Autor"
            flash.message = "No se puede generar archivo XML de los Autores por que no hemos obtenido la lista correctamente"
            redirect(controller: "autor", action: "index")
            return
        }

        def documetoXML = transferenciaListadoService.getExportListXML(listaAutores, listaAtributos)

        render("dsad")
    }
}
