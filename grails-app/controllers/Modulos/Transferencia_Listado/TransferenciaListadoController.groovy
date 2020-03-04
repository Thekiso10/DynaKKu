package Modulos.Transferencia_Listado

import Colecciones.Autor
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
            flash.message = "No se puede generar archivo XML de los Autores por que no hemos obtenido la lista correctamente"
            redirect(controller: "autor", action: "index")
            return
        }

        def datosXML = transferenciaListadoService.getExportListAutoresXML(listaAutores, pathDoc)

        if(!datosXML){
            log.error "No se ha podido generar el archivo"
            flash.message = "No se ha podido generar el archivo"
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
}
