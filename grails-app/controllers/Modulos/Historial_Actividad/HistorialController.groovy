package Modulos.Historial_Actividad

import com.itextpdf.text.Document
import dynaKKu.Modulos.Historial_Actividad.HistorialService
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Holders
import org.springframework.web.servlet.support.RequestContextUtils

class HistorialController {

    def historialService
    def registerHistorialService
    def gestorModulosService

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def index(Integer max) {
        if(!gestorModulosService.validatePermission("dynaKKu.historialActividad.enable")) {
            redirect(controller: "usuario", action: "index")
        }

        params.max = Math.min(max ?: 20, 100)
        def offset = (params.offset? Integer.parseInt(params.offset) : 0)
        Locale defaultLocale = RequestContextUtils.getLocale(request)
        //Coger una lista con toda la actividad del historial
        def listaHistorial = historialService.getAllListHistorial(defaultLocale).sort{it.date}.reverse()
        def listaHistorialCount = listaHistorial.size()
        /* Aplicar la paginación */
        listaHistorial = listaHistorial.subList(offset, Math.min (offset + params.max, listaHistorial.size()))
        /* Comprobar que la lista no este vacia */
        if(listaHistorialCount == 0){
            flash.warn = message(code: "default.list.notSize", args:[message(code: "modulos.historialActividad.title")])
        }

        //Registrar acceso
        registerHistorialService.registerModule(HistorialModulos.Modulos.HISTORIAL_ACTIVIDAD)

        //Hacer render de la vista
        render (view: 'index', model:[listaHistorial: listaHistorial, listaHistorialCount: listaHistorialCount])
    }

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def createPDF(){
        if(!gestorModulosService.validatePermission("dynaKKu.historialActividad.enable")) {
            redirect(controller: "usuario", action: "index")
        }

        Locale defaultLocale = RequestContextUtils.getLocale(request)
        //Obtener la lista de las funciones
        def listaFuncionesMangas  = historialService.getListFunctionsMangas(defaultLocale)
        def listaFuncionesAutores = historialService.getListFunctionsAutores(defaultLocale)
        def listaFuncionesModulos = historialService.getListFunctionsModulos(defaultLocale)

        render(view: 'createPDF', model: [listaFuncionesMangas: listaFuncionesMangas, 
                                          listaFuncionesAutores: listaFuncionesAutores, 
                                          listaFuncionesModulos: listaFuncionesModulos])
    }

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def generateHistorialPDF() {
        if(!gestorModulosService.validatePermission("dynaKKu.historialActividad.enable")) {
            redirect(controller: "usuario", action: "index")
        }

        //Definir variables
        Document documento
        FileInputStream fileInputStream
        OutputStream responseOutputStream
        File pdfFile
        def docName
        //Definir la ruta del banner
        def imgBanner = request.getSession().getServletContext().getRealPath((grailsApplication.config.dynaKKu.pdfConf.pathBanner))
        def pathDoc = request.getSession().getServletContext().getRealPath(('/'))
        //Obtenemos el PDF del servicio
        def doc = historialService.generateHistorialPDF(params, imgBanner, pathDoc)
        //Validamos que se haya generado el documento
        if(!doc){
            log.error "No se ha podido obtener el PDF"
            redirect(action: "createPDF")
            return
        }

        //Registrar acceso
        registerHistorialService.registerModule(HistorialModulos.Modulos.HISTORIAL_ACTIVIDAD_PDF)

        try{

            docName = doc?.docName
            documento = doc?.document

            pdfFile = new File(pathDoc + File.separator + docName);

            response.setContentType("application/pdf");
            response.addHeader("Content-Disposition", "filename=\"" + docName + "\"")
            response.setContentLength((int) pdfFile.length())
            response.setHeader("Pragma", "no-cache")

            fileInputStream = new FileInputStream(pdfFile);
            responseOutputStream = response.getOutputStream();

            int bytes
            while ((bytes = fileInputStream.read()) != -1) {
                responseOutputStream.write(bytes)
            }

        } catch (Exception e){
            log.warn "Error descargando pdf generado"
            log.error e.getMessage()
            log.error e.getCause()
        }finally{
            fileInputStream.close()
            responseOutputStream.close()
            //Delete pdf file
            pdfFile?.delete()
        }

    }
}
