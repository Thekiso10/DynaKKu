package dynaKKu.Modulos.GestorModulos

import Modulos.Gestor_Modulos.GestorModulos
import grails.transaction.Transactional

@Transactional
class GestorModulosService {

    def validatePermission(String codeConfig) {
        def value = false
        def permits = GestorModulos.findByConfigModulo(codeConfig)
        if(permits){
            value = permits.valorModulo
        }else{
            log.error("No se ha podido obtener el modulo en BBDD")
        }

        return value
    }
}
