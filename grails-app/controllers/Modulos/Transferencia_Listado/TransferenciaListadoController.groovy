package Modulos.Transferencia_Listado

import Colecciones.Autor
import Colecciones.Mangas
import grails.plugin.springsecurity.annotation.Secured

class TransferenciaListadoController {

    def transferenciaListadoService

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def ExportAutores() {
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
        //Validar el archivo
        def file = request.getFile('archivoAutor')
        if(file){
            if(!(transferenciaListadoService.validarFormatoArchivo(file))){
                log.error "El formato del archivo no es valido"
                flash.message = message(code: 'modulos.exportacionListado.export.error.code04')
                redirect(controller: "autor", action: "index")
                return
            }
        }else{
            log.error "No se ha podido recuperar el archivo xml de la importación de los Autores"
            flash.message = message(code: 'modulos.exportacionListado.export.error.code03')
            redirect(controller: "autor", action: "index")
            return
        }

        def estadoImportacion = transferenciaListadoService.importListAutoresFormFileXMl(file)
        if(estadoImportacion.codigoError){
            flash.message = message(code: estadoImportacion.codigoError)
        }else{
            def numAutores = estadoImportacion.numeroAutoresImportados
            flash.message = message(code: 'modulos.exportacionListado.panelImport.import.resultado', args: [numAutores, message(code: (numAutores > 1 ? 'layoutMenu.botonesColeccion.autores' : 'layoutMenu.botonesColeccion.autor'))])
        }

        redirect(controller: 'autor', action: 'index')
    }

    @Secured (['ROLE_ADMIN', 'ROLE_USER'])
    def ExportMangas(){
        def listaMangas = Mangas.findAllByBorrado(false)
        def pathDoc = request.getSession().getServletContext().getRealPath(('/'))
        //Variables especificas
        OutputStream out
        File xmlFile

        if(!listaMangas && listaMangas?.size() <= 0){
            log.error "Han intentado generar la exportación de Mangas sin ningun manga"
            flash.message = message(code: 'modulos.exportacionListado.export.error.code01', args: [message(code: 'layoutMenu.botonesColeccion.mangas')])
            redirect(controller: "mangas", action: "index", params: [registrado: true])
            return
        }

        def datosXML = transferenciaListadoService.getExportListMangasXML(listaMangas, pathDoc)

        if(!datosXML){
            log.error "No se ha podido generar el archivo"
            flash.message = message(code: 'modulos.exportacionListado.export.error.code02')
            redirect(controller: "mangas", action: "index", params: [registrado: true])
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
}
