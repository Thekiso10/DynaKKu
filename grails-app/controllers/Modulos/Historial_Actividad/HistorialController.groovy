package Modulos.Historial_Actividad

import com.itextpdf.text.Document
import dynamiclist.Modulos.Historial_Actividad.HistorialService
import grails.util.Holders
import org.springframework.web.servlet.support.RequestContextUtils

class HistorialController {

    def historialService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def offset = (params.offset? params.offset:0)

        render (view: 'index', model:[])
    }

    def createPDF(){
        Locale defaultLocale = RequestContextUtils.getLocale(request)
        //Obtener la lista de las funciones
        def listaFuncionesMangas  = historialService.getListFunctionsMangas(defaultLocale)
        def listaFuncionesAutores = historialService.getListFunctionsAutores(defaultLocale)
        def listaFuncionesModulos = historialService.getListFunctionsModulos(defaultLocale)

        render(view: 'createPDF', model: [listaFuncionesMangas: listaFuncionesMangas, 
                                          listaFuncionesAutores: listaFuncionesAutores, 
                                          listaFuncionesModulos: listaFuncionesModulos])
    }

    def generateHistorialPDF() {
        //Definir variables
        Document documento
        FileInputStream fileInputStream
        OutputStream responseOutputStream
        File pdfFile
        def docName
        //Definir la ruta del banner
        def imgBanner = request.getSession().getServletContext().getRealPath((grailsApplication.config.dynamicList.pdfConf.pathBanner))
        def pathDoc = request.getSession().getServletContext().getRealPath(('/'))
        //Obtenemos el PDF del servicio
        def doc = historialService.generateHistorialPDF(params, imgBanner, pathDoc)
        //Validamos que se haya generado el documento
        if(!doc){
            log.error "No se ha podido obtener el PDF"
            redirect(action: "createPDF")
            return
        }

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
            e.printStackTrace();
        }finally{
            fileInputStream.close()
            responseOutputStream.close()
            //Delete pdf file
            pdfFile?.delete()
        }

    }
}
