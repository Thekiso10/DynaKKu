package Security

import Modulos.Historial_Actividad.HistorialUsuario
import Modulos.Personalizacion_Usuario.Usuario
import dynaKKu.Modulos.Historial_Actividad.RegisterHistorialService
import grails.util.Holders
import org.springframework.context.ApplicationListener
import org.springframework.security.authentication.event.AuthenticationSuccessEvent

class MySecurityEventListener implements ApplicationListener<AuthenticationSuccessEvent> {

    //RegisterHistorialService registerHistorialService

    void onApplicationEvent(AuthenticationSuccessEvent event) {
        AuthenticationSuccessEvent authenticationSuccessEvent = (AuthenticationSuccessEvent) event
        String username = authenticationSuccessEvent.getAuthentication().getName()
        Usuario user = Usuario.findByUsername(username)
        if(user) {
            user?.setLocalLanguage()
            //Definimos una instancia del Registro del Historico
            def registerHistorialService = Holders.applicationContext.getBean("registerHistorialService") //Injectamos el service con la clase Holders
            registerHistorialService.registrarUser(user, HistorialUsuario.Status.LOGIN)
        }
    }
}
