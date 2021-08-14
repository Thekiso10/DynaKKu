package Modulos.Transferencia_Listado

import Colecciones.Autor
import Colecciones.Mangas
import com.itextpdf.text.Document
import grails.plugin.springsecurity.annotation.Secured

class TransferenciaListadoController {

    def transferenciaListadoService
    def gestorModulosService

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

        redirect(controller: "mangas", action: "index", params: [registrado: params.registrado])
    }

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def ExportarPdfManga() {
        if (!gestorModulosService.validatePermission("dynaKKu.exportacionListado.enable")) {
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
        //Obtener el PDF
    }
}
