package Modulos.Personalizacion_Usuario

import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import grails.converters.JSON
import Modulos.Personalizacion_Usuario.Usuario


class UsuarioController {

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    @Transactional
    def updateMe() {
        def resultado = [valido: true]
        def userInstance = Usuario.first()

        if(!params.nombre || !params.apellido || !params.idioma || !params.mode){
            log.error "Error al actualizar los datos del usuario. Alguno de los campos es nullo"

            resultado = [valido: false, error: 'code01']
            render resultado as JSON
            return
        }

        if(!userInstance){
            log.error "Error al actualizar los datos del usuario. La instancia del Usuario es nulla"

            resultado = [valido: false, error: 'code02']
            render resultado as JSON
            return
        }
        //Actualizar los campos del Usuario
        userInstance.nombre = params.nombre
        userInstance.apellido = params.apellido
        userInstance.idiomaDefault = params.idioma
        userInstance.modoDark = (params.mode == 'true') ? true : false;
        userInstance.ultimaModificacion = new Date()
        //Modificamos la variable de Modo Visual
        grailsApplication.config.dynaKKu.mode.oscuro = userInstance.modoDark

        log.info "Se ha podido actualizar los datos del usuario correctamente"

        render resultado as JSON
    }
}
