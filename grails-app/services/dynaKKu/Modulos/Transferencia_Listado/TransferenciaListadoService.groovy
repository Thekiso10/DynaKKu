package dynaKKu.Modulos.Transferencia_Listado

import Colecciones.Autor
import Colecciones.GenerosMangas
import grails.transaction.Transactional
import org.apache.commons.io.FilenameUtils
import org.springframework.web.multipart.commons.CommonsMultipartFile

import java.text.SimpleDateFormat
import groovy.xml.MarkupBuilder

@Transactional
class TransferenciaListadoService {

    def autorService
    def mangasService

    def getExportListAutoresXML(def listaAutores, def pathDoc){
        def formatDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date())
        def nameDoc = "ExportAutores-".concat(formatDate).concat('.xml')
        //Creamos el documento XML
        def fileWriter = new FileWriter(pathDoc + File.separator + nameDoc)
        def autoreBuilder = new MarkupBuilder(fileWriter)
        autoreBuilder.autores {
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
        //Cerramos el fichero. Esto es importante porque sino no podemos borrar despues el fichero
        fileWriter.close();
        //Devolvemos el fichero
        return [nameDoc: nameDoc, docXml: fileWriter]
    }

    def getExportListMangasXML(def listaMangas, def pathDoc){
        def formatDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date())
        def nameDoc = "ExportMangas-".concat(formatDate).concat('.xml')
        //Crear documento XML
        def fileWriter = new FileWriter(pathDoc + File.separator + nameDoc)
        def managsBuilder = new MarkupBuilder(fileWriter)
        //Generar la estructura del XML
        managsBuilder.mangas {
            listaMangas.each{ mangaInstance ->
                manga {
                    //Atributos basicos
                    nombreManga(mangaInstance.nombreManga)
                    completado(mangaInstance.completado)
                    serieAcabada(mangaInstance.serieAcabada)
                    serieConsecutiva(mangaInstance.serieConsecutiva)
                    deseado(mangaInstance.deseado)
                    numTomosActuales(mangaInstance.numTomosActuales)
                    numTomosMaximos(mangaInstance.numTomosMaximos)
                    precioTotal(mangaInstance.precioTotal)
                    fechaInscripcion(mangaInstance.fechaInscripcion)
                    ultimaModificacion(mangaInstance.ultimaModificacion)
                    mangaSpinOff((mangaInstance.mangaSpinOff ? mangaInstance.mangaSpinOff?.nombreManga : 'null'))
                    //Atributos Autor
                    autor {
                        nombreAutor(mangaInstance.autor?.nombre)
                        apellidoAutor(mangaInstance.autor?.apellido)
                    }
                    //Atributos Demografia
                    demografia {
                        nombreDemografia(mangaInstance.demografia?.nombre)
                    }
                    //Atributos genero
                    generos {
                        GenerosMangas.findAllByMangas(mangaInstance).each { generoInstance ->
                            nombreGenero(generoInstance.genero?.nombre)
                        }
                    }
                }
            }
        }
        //Cerramos el fichero. Esto es importante porque sino no podemos borrar despues el fichero
        fileWriter.close();
        //Devolvemos el fichero
        return [nameDoc: nameDoc, docXml: fileWriter]
    }

    def importListAutoresFormFileXMl(CommonsMultipartFile file){
        def listaAutores = []
        def numeroAutoresImportados = 0
        def codigoError = null
        //Definir la instancia para manejar el Archivo
        InputStream inputStream =  new BufferedInputStream(file.getInputStream())
        def autores = new XmlParser().parse(inputStream)
        //Proceder a validar obtener los datos del XML
        if(autores){
            autores.each { autor ->
                Autor autorInstance = new Autor()
                //Validar los datos
                def params = ['nombre': autor?.nombre?.text(), 'apellido': autor?.apellido?.text(), 'nacionalidad': autor?.nacionalidad?.text(), 'fechaDeNacimento': autor?.fechaNacimento?.text()]
                def validadorForm = autorService.validarForm(params, false)
                if(!validadorForm.error){
                    if(!autorService.isEqualsAuthor(params.nombre, params.apellido)){
                        autorInstance.nombre = params.nombre
                        autorInstance.apellido = params.apellido
                        autorInstance.nacionalidad = params.nacionalidad
                        if(autorService.validateUpdateNames(autorInstance, params.nombre, params.apellido)?.correcto){
                            //Protegemos este trozo de codigo porque puede ser facilmente manipulabre el XML
                            try {
                                autorInstance.fechaInscripcion = new SimpleDateFormat("dd-MM-yy HH:mm:ss").parse(autor?.fechaInscripcion?.text())
                                autorInstance.ultimaModificacion = new SimpleDateFormat("dd-MM-yy HH:mm:ss").parse(autor?.ultimaModificacion?.text())
                                autorInstance.fechaNacimento = new SimpleDateFormat("dd-MM-yy HH:mm:ss").parse(params.fechaDeNacimento)
                                if(autor?.genero?.text().equals('Masculino') || autor?.genero?.text().equals('Femenino')){
                                    autorInstance.genero = autor?.genero?.text()
                                    if(autor?.difunto?.text()?.toLowerCase()?.equals('true') || autor?.difunto?.text()?.toLowerCase()?.equals('false')){
                                        autorInstance.difunto = Boolean.parseBoolean(autor?.difunto?.text()?.toLowerCase())
                                        //Guardamos el Autor
                                        if(autorInstance.save(flush: true)){
                                            numeroAutoresImportados++
                                            log.info "Se ha tranferido el correctamente el Autor -> ${autorInstance.toString()}"
                                        }else{
                                            log.error "No se ha podido guardar el Autor"
                                        }
                                    }else{
                                        log.error "Anomalia al valiadar el campo difunto"
                                    }
                                }else{
                                    log.error "Anomalia al valiadar el genero"
                                }
                            }
                            catch (Exception e) {
                               log.error e.getMessage()
                               log.error e.getCause()
                            }
                        }else{
                            log.error "Error al volver el validar el nombre y apellido"
                        }
                    }else{
                        log.error "Error al validar el nombre y apellido"
                    }
                }else{
                    log.error "Error al validar los datos basicos"
                }
            }
        }else{
            log.error "No se ha podido parsear el archivo XML de los Autores"
            codigoError = "modulos.exportacionListado.export.error.code03"
        }

        println numeroAutoresImportados
        return [numeroAutoresImportados: numeroAutoresImportados, codigoError: codigoError]
    }

    def validarFormatoArchivo(def file){
        def correcto = true
        def extensiones = FilenameUtils.getExtension(file.originalFilename)
        //Validar si el archivo tienen formarto
        if(!extensiones.toLowerCase().equals("xml")) correcto = false

        return correcto
    }
}
