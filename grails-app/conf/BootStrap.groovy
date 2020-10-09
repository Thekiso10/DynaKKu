import Colecciones.Demografia
import Colecciones.Genero
import Modulos.Gestor_Modulos.GestorModulos
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

        /* Haremos la comprobacion de carpetas siempre */
        comprobarCarpetas()
        /* Cargar la lista de variables para los modulos */
        cargarVariablesGestorModulos()

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
        log.debug "userToRole = " + userToRole.save(flush:true)

        def wsToRole = new UserRole(user: ws, role: wsRole)
        log.debug "wsToRole = " + wsToRole.save(flush:true)
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
        log.info "</> Fin de hacer comprobacion de Carpetas | Tiempo de duracion: ["+ TimeCategory.minus(new Date(), timeStart) +"] </>"
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
    //Cargar la lista de variables para los modulos
    def cargarVariablesGestorModulos(){
        def timeStart = new Date()
        log.info "</> Comprobar Gestor de Modulos </>"
        //Definimos los terminos de busqueda
        def search = "enable"
        def nameI18n = "title"
        //Vamos a recoger el bucle de los modulos
        def listModules = grailsApplication.config.dynaKKu.listModules
        listModules.each { module ->
            String nameModule = "dynaKKu.$module.$search"
            if(!GestorModulos.findByConfigModulo(nameModule)){
                GestorModulos gestorInstance = new GestorModulos()
                //Guardar datos
                gestorInstance.configModulo         = nameModule
                gestorInstance.nombreModulo         = "modulos.$module.$nameI18n"
                gestorInstance.valorModulo          = grailsApplication.config.getProperty(nameModule)
                gestorInstance.fechaCreacion        = new Date()
                gestorInstance.ultimaModificacion   = new Date()
                //Guardamos la instacia
                if(gestorInstance.save(flush: true)){
                    log.info "</> Generado el modulo -> $nameModule </>"
                }else{
                    log.error "</> No se ha podido generar el modulo -> $nameModule </>"
                }
            }
        }

        log.info "</> Fin de la Comprobación del Gestor de Modulos | Tiempo de duracion: ["+ TimeCategory.minus(new Date(), timeStart) +"] </>"
    }


    def private guardarLista(def lista){
        lista.each {
            if(!it.save()){
                log.error "[Alerta] No se ha podido guardar la demografia -> " + it.nombre
            }
        }
    }
}
