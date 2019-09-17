import Colecciones.Demografia
import Colecciones.Genero

class BootStrap {
    //Cargar las variables de Configuracion
    def grailsApplication

    def init = { servletContext ->
        log.info "## Cargar BootStrap ##"

        if (grailsApplication.config.dataSource.dbCreate.equals("create")){
            cargarDemografias()
            cargarGeneros()
        }else if (grailsApplication.config.dataSource.dbCreate.equals("update")){

        }

        log.info "## Fin de cargar BootStrap ##"
    }
    def destroy = {
    }

    def cargarDemografias(){
        log.info "Creando Demografias"
        def listaDemografia = []
        //Llenar la lista con diferentes demografias
        listaDemografia << new Demografia(nombre: "Kodomo")
        listaDemografia << new Demografia(nombre: "Shonen")
        listaDemografia << new Demografia(nombre: "Shojo")
        listaDemografia << new Demografia(nombre: "Seinen")
        listaDemografia << new Demografia(nombre: "Josei")
        //Llamar al metodo para guardar la lista
        guardarLista(listaDemografia)
    }

    def cargarGeneros() {
        log.info "Creando Generos"
        def listaGenero = []
        //Llenar la lista con diferentes generos
        listaGenero << new Genero(nombre:"Nekketsu")
        listaGenero << new Genero(nombre:"Spokon")
        listaGenero << new Genero(nombre:"Gekiga")
        listaGenero << new Genero(nombre:"Mahō Shōjo")
        listaGenero << new Genero(nombre:"Yuri")
        listaGenero << new Genero(nombre:"Yaoi")
        listaGenero << new Genero(nombre:"Harem")
        listaGenero << new Genero(nombre:"Mecha:")
        listaGenero << new Genero(nombre:"Ecchi")
        listaGenero << new Genero(nombre:"Jidaimono")
        listaGenero << new Genero(nombre:"Gore")
        //Llamar al metodo para guardar la lista
        guardarLista(listaGenero)
    }

    def guardarLista(def lista){
        lista.each {
            if(!it.save()){
                log.error "[Alerta] No se ha podido guardar la demografia -> " + it.nombre
            }
        }
    }
}
