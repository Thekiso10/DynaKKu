import Colecciones.Demografia
import Colecciones.Genero
import Modulos.Personalizacion_Usuario.Usuario
import groovy.time.TimeDuration
import groovy.time.TimeCategory
import org.apache.commons.io.FilenameUtils

class BootStrap {
    //Cargar las variables de Configuracion
    def grailsApplication
    def localeResolver

    def init = { servletContext ->
        cargarLogo()
        log.info "## Cargar BootStrap ##"

        if (grailsApplication.config.dataSource.dbCreate.equals("create")){

            cargarDemografias()
            cargarGeneros()

            log.info "</> Creando usuario por defecto </>"
            def user = new Usuario(nombre: 'Admin', apellido: 'Default', idiomaDefault: 'es', modoDark: true, ultimaModificacion: new Date())
            if(!user.save(flush: true)) log.error "No se ha podido crear el usuario por defecto"

        }else if (grailsApplication.config.dataSource.dbCreate.equals("update")){

        }

        comprobarCarpetas() //Haremos la comprobacion de carpetas siempre
        cargarIdioma() //Hacemos que cargue el idioma, en local, configurado por el usuario

        log.info "## Fin de cargar BootStrap ##"
    }
    def destroy = {
    }
    //Comprobar si las carpetas externas existen
    def comprobarCarpetas(){
        log.info "</> Hacer comprobacion de Carpetas </>"
        //Definir variable de tiempo para definir tiempo de ejecucion
        def timeStart = new Date()
        //Definir la lista de files
        ArrayList<File> listaCarpetas = []
        //Definir la ruta de las carpetas que hay que comprobar y Colocar los files en la lista
        listaCarpetas << new File(grailsApplication.config.dynamicList.autores.rutaImg)
        listaCarpetas << new File(grailsApplication.config.dynamicList.mangas.rutaImg)
        //Ejecutar las comparaciones
        try{
            listaCarpetas.each { folder ->
                if(!folder.exists()){
                    if(!FilenameUtils.getExtension(folder.getPath())){ //Comprobamos si la ruta tiene alguna extension
                        if(folder.mkdirs()){
                            log.info "Se ha creado el directorio de -> " + folder.getPath()
                        }else{
                            log.error "No se ha podido crear el directorio de -> " + folder.getPath()
                        }
                    }else{
                        log.error "No se puede generar un archivo como directorio | path -> " + folder.getPath()
                    }
                }
            }
        }catch (Exception e){
            log.error e
        }catch (SecurityException se){
            log.error se
        }
        //Ejecutar calculo de comparacion
        def timeStop = new Date()
        TimeDuration duration = TimeCategory.minus(timeStop, timeStart)
        log.info "</> Fin de hacer comprobacion de Carpetas | Tiempo de duracion: ["+ duration +"] </>"
    }
    //Cargar la lista de demografias
    def cargarDemografias(){
        log.info "</> Creando Demografias </>"
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
    //Cargar la lista de generos
    def cargarGeneros() {
        log.info " </> Creando Generos </>"
        def listaGenero = []
        //Llenar la lista con diferentes generos
        listaGenero << new Genero(nombre:"Nekketsu")
        listaGenero << new Genero(nombre:"Spokon")
        listaGenero << new Genero(nombre:"Gekiga")
        listaGenero << new Genero(nombre:"Mahō Shōjo")
        listaGenero << new Genero(nombre:"Yuri")
        listaGenero << new Genero(nombre:"Yaoi")
        listaGenero << new Genero(nombre:"Harem")
        listaGenero << new Genero(nombre:"Mecha")
        listaGenero << new Genero(nombre:"Ecchi")
        listaGenero << new Genero(nombre:"Jidaimono")
        listaGenero << new Genero(nombre:"Gore")
        //Llamar al metodo para guardar la lista
        guardarLista(listaGenero)
    }

    def cargarIdioma(){
        log.info "</> Cargar idioma antes de arrancar la apliación </>"
        //Buscamos, en la table Usuario, el idioma configurado por el usuario. Si es null, establecemos por defecto en 'Es'
        def userInstance = (Usuario.first()) ?: null
        def idioma = (userInstance) ? userInstance.idiomaDefault : 'null'
        Locale defaultLocale
        //Mostramos cual es el idioma en BBDD. Sale null si no se ha encontrada nada en la BBDD
        log.info "</> Idioma detectado -> [" + idioma + "]"
        //Configuramos la variable Locale a partir de la variable 'idioma'
        switch (idioma){
            case 'es':
                defaultLocale = new Locale('es')
                break
            case 'ca':
                defaultLocale = new Locale('ca','ES')
                break
            case 'en':
                defaultLocale = new Locale('en','US')
                break
            default:
                defaultLocale = new Locale('es')
                break
        }
        //Cargamos el idioma en la sessión local del navegador del usuario
        localeResolver.defaultLocale = defaultLocale
        log.info "</> Cargar el Modo Visual </>"
        grailsApplication.config.dynamicList.mode.oscuro = (userInstance) ? userInstance.modoDark : true
        log.info "</> Modo Oscuro -> [" + grailsApplication.config.dynamicList.mode.oscuro + "]"
    }

    def guardarLista(def lista){
        lista.each {
            if(!it.save()){
                log.error "[Alerta] No se ha podido guardar la demografia -> " + it.nombre
            }
        }
    }

    def cargarLogo(){
        println "\n\n"
        println " _|_|_|                                                  _|            _|        _|              _|     "
        println " _|    _|  _|    _|  _|_|_|      _|_|_|  _|_|_|  _|_|          _|_|_|  _|              _|_|_|  _|_|_|_| "
        println " _|    _|  _|    _|  _|    _|  _|    _|  _|    _|    _|  _|  _|        _|        _|  _|          _|     "
        println " _|    _|  _|    _|  _|    _|  _|    _|  _|    _|    _|  _|  _|        _|        _|     _|       _|     "
        println " _|    _|  _|    _|  _|    _|  _|    _|  _|    _|    _|  _|  _|        _|        _|        _|    _|     "
        println " _|_|_|    _|_|_|_|  _|    _|    _|_|_|  _|    _|    _|  _|    _|_|_|  _|_|_|_|  _|  _|_|_|_|      _|_| "
        println "                 _| "
        println "             _|_|   "
        println "\n\n"
    }
}
