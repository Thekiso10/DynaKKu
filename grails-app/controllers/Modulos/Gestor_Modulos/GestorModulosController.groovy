package Modulos.Gestor_Modulos

import grails.plugin.springsecurity.annotation.Secured

class GestorModulosController {

    @Secured (['ROLE_ADMIN'])
    def panel() {

        render (view: "panel")
    }
}
