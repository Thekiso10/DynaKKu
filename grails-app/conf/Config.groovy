import java.util.logging.Logger;

// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination

// The ACCEPT header will not be used for content negotiation for user agents containing the following strings (defaults to the 4 major rendering engines)
grails.mime.disable.accept.header.userAgents = ['Gecko', 'WebKit', 'Presto', 'Trident']
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.types = [ // the first one is the default format
    all:           '*/*', // 'all' maps to '*' or the first available format in withFormat
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    hal:           ['application/hal+json','application/hal+xml'],
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// Legacy setting for codec used to encode data with ${}
grails.views.default.codec = "html"

// The default scope for controllers. May be prototype, session or singleton.
// If unspecified, controllers are prototype scoped.
grails.controllers.defaultScope = 'singleton'

// GSP settings
grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
            codecs {
                expression = 'html' // escapes values inside ${}
                scriptlet = 'html' // escapes output from scriptlets in GSPs
                taglib = 'none' // escapes output from taglibs
                staticparts = 'none' // escapes output from static template parts
            }
        }
        // escapes all not-encoded output at final stage of outputting
        // filteringCodecForContentType.'text/html' = 'html'
    }
}


grails.converters.encoding = "UTF-8"
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

// configure passing transaction's read-only attribute to Hibernate session, queries and criterias
// set "singleSession = false" OSIV mode in hibernate configuration after enabling
grails.hibernate.pass.readonly = false
// configure passing read-only to OSIV session by default, requires "singleSession = false" OSIV mode
grails.hibernate.osiv.readonly = false

environments {
    development {
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
    }
}

log4j = {
	info "grails.app"
}

// log4j configuration
log4j.main = {
    // Example of changing the log pattern for the default console appender:
    //
    appenders {
        console name:'stdout', layout:pattern(conversionPattern: '%d [%-5p] %c{1} ::: %m%n')
    }
    info 'grails.app','org.codehaus.groovy.grails.plugins.springsecurity','com.semic.enotumclient'
    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
}

/*======================================================*/
/*				SPRING SECURITY PLUGIN					*/
/*======================================================*/
grails.plugin.springsecurity.userLookup.userDomainClassName     = 'Modulos.Personalizacion_Usuario.Usuario'
grails.plugin.springsecurity.userLookup.authorityJoinClassName  = 'Security.UserRole'
grails.plugin.springsecurity.authority.className                = 'Security.Role'
grails.plugin.springsecurity.logout.postOnly                    = false //Para permitir el acceso GET
grails.plugin.springsecurity.securityConfigType                 = "Annotation"
grails.plugin.springsecurity.useSecurityEventListener           = true //Activar la eschuca de los evenetos

grails.plugin.springsecurity.controllerAnnotations.staticRules = [
        '/assets/**':      ['permitAll'],
        '/web-app/**':     ['permitAll'],
        '/**/js/**':       ['permitAll'],
        '/**/fonts/**':    ['permitAll'],
        '/**/css/**':      ['permitAll'],
        '/**/images/**':   ['permitAll'],
        '/**/webfonts/**': ['permitAll'],
        '/**/favicon.ico': ['permitAll']
]

/*==================================================================*/
/* 		                        Modo                       			*/
/*==================================================================*/
dynaKKu.version.app         = null
dynaKKu.version.notas.url   = "https://github.com/Thekiso10/DynaKKu/releases"
dynaKKu.listModules         = ["estadisticas", "historialActividad", "exportacionListado"]

/*==================================================================*/
/* 		                       Autores                     			*/
/*==================================================================*/
dynaKKu.autores.rutaImg = "web-app\\images\\imgAutores" //Ruta para guardar las imagenes de cada autor
dynaKKu.autores.edadMax = 110 	//Especificar la edad minima de un Autor
dynaKKu.autores.edadMin = 0 	//Especificar la edad maxima de un Autor
/* Logitut del nombre */
dynaKKu.autores.longitut.nombreMax = 25 //Especificar la logitut maxima del nombre

/*==================================================================*/
/* 		                      Mangas                      			*/
/*==================================================================*/
dynaKKu.mangas.rutaImg = "web-app\\images\\imgMangas" //Ruta para guardar las imagenes de cada manga
dynaKKu.mangas.longitut.nombreMax  = 50 //Especificar la logitut maxima del nombre
dynaKKu.mangas.longitut.generosMax = 5 //Especificar el numero maximo de generos permitidos para un mismo Manga
dynaKKu.mangas.longitut.tomosMax   = 150 //Especificar el numero maximo de tomos que puedes registrar

/*==================================================================*/
/* 		                     Imagenes                      			*/
/*==================================================================*/
dynaKKu.colecciones.photoSize	= 4 * 1024 * 1024 	// Tamaño maximo de la foto (4MB)

/*==================================================================*/
/* 		                Historial Actividad                			*/
/*==================================================================*/
dynaKKu.historialActividad.enable = true //Activar el modulo de Historial
dynaKKu.pdfConf.pathBanner = "images/imgWeb/pdf/bannerPDF.png"

/*==================================================================*/
/* 		                   Estadisticas                  			*/
/*==================================================================*/
dynaKKu.estadisticas.enable = true //Activar el modulo de Estadisticas

/*==================================================================*/
/* 		              Transferencia Listado                			*/
/*==================================================================*/
dynaKKu.exportacionListado.enable = true //Activar el modulo de Tranferencia de Listados

/*==================================================================*/
/* 					   Configuración interna       					*/
/*==================================================================*/
app.rutaConfig.ruta = System.getProperty("personalitzacio") ?: "pre"

/*==================================================================*/
/* 					   Cargar Config Externa       					*/
/*==================================================================*/
Properties props = new Properties()
log.info "llegint application.properties"
def arxiuConfig
def rutaConfig

try {
	props.load(getClass().getResourceAsStream("application.properties"));
	rutaConfig = props.get("app.rutaConfig")
	if (!rutaConfig){
		throw new Exception("No se ha encontrado la entrada app.rutaConfig en el archivo application.properties")
		System.exit(1)
	}

    dynaKKu.version.app = props.get("app.version")
    if (!dynaKKu.version.app){
        throw new Exception("No se ha encontrado la entrada app.version en el archivo application.properties")
        System.exit(1)
    }

	// determina si la ruta depèn del context de deployment o és absoluta
	if(rutaConfig.contains('/') || rutaConfig.contains('\\')){
		arxiuConfig	= rutaConfig + File.separator + "Config.groovy"
	}

	File f = new File(arxiuConfig);
	if (!f.exists())
		throw new Exception("ERROR: No existeix l'arxiu de configuració ${arxiuConfig}.\n\t - Revisar la ruta a l'arxiu application.properties")
	f = null;
} catch (Exception e) {
	log.error "Excepció ${e.class}:: Missatge:${e.getMessage()}"
	System.exit(1)
}

grails.config.locations = ["file:${arxiuConfig}"]

dir.config  = rutaConfig
pressoffice.dir.config  = rutaConfig

log.info "Config Loaded...OK\n"