package Modulos.Transferencia_Listado

import Colecciones.Autor
import Colecciones.Mangas
import Modulos.Historial_Actividad.HistorialModulos
import com.itextpdf.text.Document
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.support.RequestContextUtils as RCU

class TransferenciaListadoController {

    def transferenciaListadoService
    def gestorModulosService
    def registerHistorialService

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def ExportAutores() {
        if(!gestorModulosService.validatePermission("dynaKKu.exportacionListado.enable")) {
            redirect(controller: "usuario", action: "index")
        }

        def listaAutores = Autor.findAllByBorrado(false)
        def pathDoc = request.getSession().getServletContext().getRealPath(('/'))
        //Variables especificas
        OutputStream out
        File xmlFile

        if(!listaAutores && listaAutores?.size() <= 0){
            log.error "Han intentado generar la exportación de Autores sin ningun Autor"
            flash.message = message(code: 'modulos.exportacionListado.export.error.code01', args: [message(code: 'layoutMenu.botonesColeccion.autores')])
            redirect(controller: "autor", action: "index")
            return
        }

        def datosXML = transferenciaListadoService.getExportListAutoresXML(listaAutores, pathDoc)

        if(!datosXML){
            log.error "No se ha podido generar el archivo"
            flash.message = message(code: 'modulos.exportacionListado.export.error.code02')
            redirect(controller: "autor", action: "index")
            return
        }

        //Registrar acceso
        registerHistorialService.registerModule(HistorialModulos.Modulos.EXPORTACION_LISTADO_AUTOR)

        try{
            def docName = datosXML?.nameDoc
            def documento = datosXML?.docXml

            xmlFile = new File(pathDoc + File.separator + docName)

            response.setContentType("application/xml")
            response.setHeader("Content-disposition", "attachment;filename=${xmlFile.getName()}")

            out = response.getOutputStream()
            out.write(xmlFile.bytes)

        }catch (Exception e){
            log.warn "Error descargando pdf generado"
            log.error e.getMessage()
            log.error e.getCause()
        }finally{
            out.close()
            //Delete pdf file
            xmlFile?.delete()
        }
    }

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def ImportAutor(){
        if(!gestorModulosService.validatePermission("dynaKKu.exportacionListado.enable")) {
            redirect(controller: "usuario", action: "index")
        }

        //Validar el archivo
        def file = request.getFile('archivoAutor')
        if(file){
            if(transferenciaListadoService.validarFormatoArchivo(file)){
                def estadoImportacion = transferenciaListadoService.importListAutoresFormFileXMl(file)
                if(estadoImportacion.codigoError){
                    flash.message = message(code: estadoImportacion.codigoError)
                }else{
                    def numAutores = estadoImportacion.numeroAutoresImportados
                    flash.message = message(code: 'modulos.exportacionListado.panelImport.import.resultado', args: [numAutores, message(code: (numAutores > 1 ? 'layoutMenu.botonesColeccion.autores' : 'layoutMenu.botonesColeccion.autor'))])
                }
            }else{
                log.error "El formato del archivo no es valido"
                flash.message = message(code: 'modulos.exportacionListado.export.error.code04')
            }
        }else{
            log.error "No se ha podido recuperar el archivo xml de la importación de los Autores"
            flash.message = message(code: 'modulos.exportacionListado.export.error.code03')
        }

        //Registrar acceso
        registerHistorialService.registerModule(HistorialModulos.Modulos.IMPORACION_LISTADO_AUTOR)

        redirect(controller: 'autor', action: 'index')
    }

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def ExportMangas(){
        if(!gestorModulosService.validatePermission("dynaKKu.exportacionListado.enable")) {
            redirect(controller: "usuario", action: "index")
        }

        def listaMangas = Mangas.findAllByBorrado(false)
        def pathDoc = request.getSession().getServletContext().getRealPath(('/'))
        //Variables especificas
        OutputStream out
        File xmlFile

        if(!listaMangas && listaMangas?.size() <= 0){
            log.error "Han intentado generar la exportación de Mangas sin ningun manga"
            flash.message = message(code: 'modulos.exportacionListado.export.error.code01', args: [message(code: 'layoutMenu.botonesColeccion.mangas')])
            redirect(controller: "mangas", action: "index", params: [registrado: params.registrado])
            return
        }

        def datosXML = transferenciaListadoService.getExportListMangasXML(listaMangas, pathDoc)

        if(!datosXML){
            log.error "No se ha podido generar el archivo"
            flash.message = message(code: 'modulos.exportacionListado.export.error.code02')
            redirect(controller: "mangas", action: "index", params: [registrado: params.registrado])
            return
        }

        //Registrar acceso
        registerHistorialService.registerModule(HistorialModulos.Modulos.EXPORTACION_LISTADO_MANGAS)

        try{
            def docName = datosXML?.nameDoc
            def documento = datosXML?.docXml

            xmlFile = new File(pathDoc + File.separator + docName)

            response.setContentType("application/xml")
            response.setHeader("Content-disposition", "attachment;filename=${xmlFile.getName()}")

            out = response.getOutputStream()
            out.write(xmlFile.bytes)

        }catch (Exception e){
            log.warn "Error descargando pdf generado"
            log.error e.getMessage()
            log.error e.getCause()
        }finally{
            out.close()
            //Delete pdf file
            xmlFile?.delete()
        }
    }

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def ImportMangas(){
        if(!gestorModulosService.validatePermission("dynaKKu.exportacionListado.enable")) {
            redirect(controller: "usuario", action: "index")
        }

        //Validar el archivo
        def file = request.getFile('archivoMangas')
        if(file){
            if(transferenciaListadoService.validarFormatoArchivo(file)){
                def estadoImportacion = transferenciaListadoService.importListMangasFormFileXMl(file)
                if(estadoImportacion.codigoError){
                    flash.message = message(code: estadoImportacion.codigoError)
                }else{
                    def numMangas = estadoImportacion.numeroMangasImportados
                    flash.message = message(code: 'modulos.exportacionListado.panelImport.import.resultado', args: [numMangas, message(code: (numMangas > 1 ? 'layoutMenu.botonesColeccion.mangas' : 'layoutMenu.botonesColeccion.manga'))])
                }
            }else{
                log.error "El formato del archivo no es valido"
                flash.message = message(code: 'modulos.exportacionListado.export.error.code04')
            }
        }else{
            log.error "No se ha podido recuperar el archivo xml de la importación de los Autores"
            flash.message = message(code: 'modulos.exportacionListado.export.error.code03')
        }

        //Registrar acceso
        registerHistorialService.registerModule(HistorialModulos.Modulos.IMPORACION_LISTADO_MANGAS)

        redirect(controller: "mangas", action: "index", params: [registrado: params.registrado])
    }

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def ExportarCollectionPdf(){
        if (!gestorModulosService.validatePermission("dynaKKu.exportacionListado.enable")) {
            redirect(controller: "usuario", action: "index")
        }

        //Definir variables
        FileInputStream fileInputStream
        OutputStream responseOutputStream
        File pdfFile
        def docName
        //Definir la ruta del banner
        def imgBanner = request.getSession().getServletContext().getRealPath((grailsApplication.config.dynaKKu.pdfConf.pathBanner))
        def pathDoc = request.getSession().getServletContext().getRealPath(('/'))
        //Obtener el PDF
        def doc = transferenciaListadoService.generateListadoPDF(params.collection, RCU.getLocale(request), imgBanner, pathDoc)

        //Registrar acceso
        registerHistorialService.registerModule(HistorialModulos.Modulos.LISTADO_PDF)

        try{
            docName = doc?.docName

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
