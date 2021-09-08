package Modulos.Gestor_Modulos

import Modulos.Historial_Actividad.HistorialModulos
import grails.plugin.springsecurity.annotation.Secured

class GestorModulosController {

    def registerHistorialService

    @Secured (['ROLE_ADMIN'])
    def panel() {
        //Obtener la lista completa de los modulos
        def listModules = GestorModulos.list()
        //Validamos que la lista no este vacia
        if(listModules.size() == 0){
            flash.message = message(code: "default.list.notSize", args:[message(code: "modulos.gestorModulos.title")])
        }

        //Registrar acceso
        registerHistorialService.registerModule(HistorialModulos.Modulos.GESTOR_MODULOS)

        render (view: "panel", model:[listModules: listModules])
    }

    @Secured (['ROLE_ADMIN'])
    def updateValue() {
        //Obtenemos el modulo
        def moduleInstace = GestorModulos.get(params.id)
        if(moduleInstace){
            //Actaulizar el valor
            moduleInstace?.valorModulo = !moduleInstace?.valorModulo
            if(moduleInstace.save(flush: true)){
                flash.message = message(code: "modulos.gestorModulos.updateValue")
            }else{
                log.error "No se ha guardar el modulo"
                flash.error = message(code: "modulos.gestorModulos.error.update")
            }
        }else{
            log.error "No se ha podido obtener el modulo"
            flash.error = message(code: "modulos.gestorModulos.error.update")
        }

        redirect (action: "panel")
    }
}
