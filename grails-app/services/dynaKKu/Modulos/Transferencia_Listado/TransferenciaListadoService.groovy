package dynaKKu.Modulos.Transferencia_Listado

import grails.transaction.Transactional
import java.text.SimpleDateFormat
import groovy.xml.MarkupBuilder

@Transactional
class TransferenciaListadoService {

    def getExportListAutoresXML(def listaAutores, def pathDoc){
        def formatDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date())
        def nameDoc = "ExportAutores-".concat(formatDate).concat('.xml')
        //Creamos el documento XML
        def fileWriter = new FileWriter(pathDoc + File.separator + nameDoc)
        def peopleBuilder = new MarkupBuilder(fileWriter)
        peopleBuilder.autores {
            listaAutores.each{ autorInstance ->
                autor {
                    nombre(autorInstance?.nombre)
                    apellido(autorInstance?.apellido)
                    nacionalidad(autorInstance?.nacionalidad)
                    genero(autorInstance?.genero)
                    difunto(autorInstance?.difunto)
                    fechaNacimento(autorInstance?.fechaNacimento)
                    fechaInscripcion(autorInstance?.fechaInscripcion)
                    ultimaModificacion(autorInstance?.ultimaModificacion)

                }
            }
        }
        fileWriter.close();

        return [nameDoc: nameDoc, docXml: fileWriter]
    }
}
