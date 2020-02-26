import Colecciones.Demografia
import Colecciones.Genero
import Security.*
import Modulos.Personalizacion_Usuario.Usuario
import groovy.time.TimeDuration
import groovy.time.TimeCategory
import org.apache.commons.io.FilenameUtils
import org.apache.commons.lang.RandomStringUtils

class BootStrap {
    //Cargar las variables de Configuracion
    def grailsApplication
    def localeResolver

    def init = { servletContext ->
        log.info "## Cargar BootStrap ##"

        if (grailsApplication.config.dataSource.dbCreate.equals("create") || grailsApplication.config.dataSource.dbCreate.equals("create-drop")){
            /* Creamos las demografia */
            cargarDemografias()
            /* Creamos los generos */
            cargarGeneros()
            /* Creamos los usuarios */
            creacionUsuariosDefecto()
        }else if (grailsApplication.config.dataSource.dbCreate.equals("update")){
            //Por si algun dia lo necesitamos
        }

        comprobarCarpetas() //Haremos la comprobacion de carpetas siempre
        cargarIdioma() //Hacemos que cargue el idioma, en local, configurado por el usuario

        log.info "## Fin de cargar BootStrap ##"
    }
    def destroy = {
    }
    def creacionUsuariosDefecto() {
        log.info "</> Creando usuario por defecto </>"
        String charset = (('A'..'Z') + ('0'..'9') + ('a'..'z') + ('@'+'#'+'.'+'-')).join()
        Integer length = 15
        //Generar las contraseñas
        String passAdmin = RandomStringUtils.random(length, charset.toCharArray())
        String passUser  = RandomStringUtils.random(length, charset.toCharArray())
        String passWS    = RandomStringUtils.random(length, charset.toCharArray())
        //Creamos a los usuario por defecto
        def admin = new Usuario(nombre: 'Admin', apellido: 'Default',
                                idiomaDefault: 'es', modoDark: true, ultimaModificacion: new Date(),
                                fechaCreacion: new Date(), username: 'admin', password: passAdmin).save()

        def user  = new Usuario(nombre: 'Usuario', apellido: 'Default',
                                idiomaDefault: 'es', modoDark: true, ultimaModificacion: new Date(),
                                fechaCreacion: new Date(), username: 'user', password: passUser).save()

        def ws    = new Usuario(nombre: 'Usuario', apellido: 'WebService',
                                idiomaDefault: 'es', modoDark: true, ultimaModificacion: new Date(),
                                fechaCreacion: new Date(), username: 'user_ws', password: passWS).save()

        //Creamos los roles por defecto
        def adminRole   = new Role(authority: 'ROLE_ADMIN').save()
        def userRole    = new Role(authority: 'ROLE_USER').save()
        def wsRole      = new Role(authority: 'ROLE_WS').save()
        //Configuramos los Roles a los usuarios
        def adminToRole = new UserRole(user: admin, role: adminRole)
        log.debug "adminToRole = " + adminToRole.save(flush:true)

        def userToRole = new UserRole(user: user, role: userRole)
        log.debug "userToRole = " + adminToRole.save(flush:true)

        def wsToRole = new UserRole(user: ws, role: wsRole)
        log.debug "wsToRole = " + adminToRole.save(flush:true)
        //Mostrar las contraseñas por los logs
        log.info "Contraseña Admin -> " + passAdmin
        log.info "Contraseña User -> " + passUser
        log.info "Contraseña User WebService -> " + passWS

        log.info "</> Fin usuario por defecto </>"
    }
    //Comprobar si las carpetas externas existen
    def comprobarCarpetas(){
        log.info "</> Hacer comprobacion de Carpetas </>"
        //Definir variable de tiempo para definir tiempo de ejecucion
        def timeStart = new Date()
        //Definir la lista de files
        ArrayList<File> listaCarpetas = []
        //Definir la ruta de las carpetas que hay que comprobar y Colocar los files en la lista
        listaCarpetas << new File(grailsApplication.config.dynaKKu.autores.rutaImg)
        listaCarpetas << new File(grailsApplication.config.dynaKKu.mangas.rutaImg)
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
        grailsApplication.config.dynaKKu.mode.oscuro = (userInstance) ? userInstance.modoDark : true
        log.info "</> Modo Oscuro -> [" + grailsApplication.config.dynaKKu.mode.oscuro + "]"
    }

    def guardarLista(def lista){
        lista.each {
            if(!it.save()){
                log.error "[Alerta] No se ha podido guardar la demografia -> " + it.nombre
            }
        }
    }
}
