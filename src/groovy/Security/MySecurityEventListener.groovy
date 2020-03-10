package Security

import Modulos.Personalizacion_Usuario.Usuario
import org.springframework.context.ApplicationListener
import org.springframework.security.authentication.event.AuthenticationSuccessEvent

class MySecurityEventListener implements ApplicationListener<AuthenticationSuccessEvent> {

    void onApplicationEvent(AuthenticationSuccessEvent event) {
        AuthenticationSuccessEvent authenticationSuccessEvent = (AuthenticationSuccessEvent) event
        String username = authenticationSuccessEvent.getAuthentication().getName()
        Usuario.findByUsername(username)?.setLocalLanguage()
    }
}
