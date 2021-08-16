package dynaKKu.Modulos.Personalizacion_Usuario

import grails.transaction.Transactional

@Transactional
class UsuarioService {

    /*------------------------- validatePassword ---------------------------*/
    /*																		*/
    /* Validar que la contraseña tenga al menos 8 carácteres y no más de 64,*/
    /* una mayúscula, un número y un carácter especial						*/
    /*----------------------------------------------------------------------*/
    def validatePassword(password){
        def validate = false

        if((password.length() > 8 && password.length() < 64) &&
                (password.matches('^.*\\p{Alpha}.*$') && password.matches('^.*\\p{Digit}.*$') && password.matches('^.*[-*!$%&()_+={}:;<>?,.@#].*$'))){
            validate = true
        }

        return validate
    }
}
