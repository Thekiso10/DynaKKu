package Modulos.Personalizacion_Usuario

import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

class UsuarioController {

    def springSecurityService
    def usuarioService
    def estadisticasService

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def index(){
        //Cogemos al usuario logueado
        def userInstance = springSecurityService.currentUser
        def valueTomos = estadisticasService.getPercentCompletedTomosMangas()
        def valueMangasCompleted = estadisticasService.getPercentCompletedMangas()
        def valueMangasConcluded = estadisticasService.getPercentConcludedMangas()

        render(view: 'index', model: [userInstance: userInstance, valueTomos: valueTomos, valueMangasCompleted: valueMangasCompleted, valueMangasConcluded: valueMangasConcluded])
    }

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    @Transactional
    def updateMe() {
        def userInstance = Usuario.findById(params.id)

        if(!userInstance){
            log.error "Error al actualizar los datos del usuario. La instancia del Usuario es nulla"

            render (status:403, text: message(code: 'layoutMenu.configuracion.save.error.code02'))
            return
        }

        if(!params.nombre || !params.apellido || !params.idioma || !params.mode || !params.username || !params.email){
            log.error "Error al actualizar los datos del usuario. Alguno de los campos es nullo"

            render (status:403, text: message(code: 'layoutMenu.configuracion.save.error.code01'))
            return
        }

        if(params.changePasswordParam.equals('true')){
            if(!params.password || !params.repitPassword){
                render (status:403, text: message(code: 'layoutMenu.configuracion.save.error.code01'))
                return
            }

            if (!params.password.equals(params.repitPassword)){
                render (status:403, text: message(code: 'layoutMenu.configuracion.save.error.code03'))
                return
            }

            if(!usuarioService.validatePassword(params.password)){
                render (status:403, text: message(code: 'layoutMenu.configuracion.save.error.code05'))
                return
            }
        }

        if(params.username.contains(" ")){
            render (status:403, text: message(code: 'layoutMenu.configuracion.save.error.code04'))
            return
        }

        //Actualizar los campos del Usuario
        userInstance.nombre = params.nombre
        userInstance.apellido = params.apellido
        userInstance.password = params.password
        userInstance.mail = params.email
        userInstance.idiomaDefault = params.idioma
        userInstance.modoDark = (params.mode == 'true') ? true : false
        userInstance.ultimaModificacion = new Date()
        //Guardamos la instancia
        if(!userInstance.save(flush: true)){
            log.error("No se ha podido guardar el usuario")
        }
        //Vamos a cambiar el idioma del navegador
        userInstance.setLocalLanguage()

        log.info "Se ha podido actualizar los datos del usuario correctamente"

        render (status:200, text: message(code: 'layoutMenu.configuracion.save.correcto'))
    }
}
