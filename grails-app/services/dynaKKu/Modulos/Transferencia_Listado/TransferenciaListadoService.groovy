package dynaKKu.Modulos.Transferencia_Listado

import Colecciones.Autor
import Colecciones.Demografia
import Colecciones.Genero
import Colecciones.GenerosMangas
import Colecciones.Mangas
import grails.transaction.Transactional
import grails.util.Holders
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
                            }catch (Exception e) {
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

        return [numeroAutoresImportados: numeroAutoresImportados, codigoError: codigoError]
    }

    def importListMangasFormFileXMl(CommonsMultipartFile file){
        def listaMangasConSpinOff = []
        def listaMangasSinSpinOff = []
        def numeroMangasImportados = 0
        def codigoError = null
        //Definir la instancia para manejar el Archivo
        InputStream inputStream =  new BufferedInputStream(file.getInputStream())
        def mangas = new XmlParser().parse(inputStream)
        if(mangas){
            //Colocamos los mangas en una lista para
            mangas.each { manga ->
                (manga.mangaSpinOff.equals('null') ? listaMangasSinSpinOff << [nodoManga: manga] : listaMangasConSpinOff << [nodoManga: manga])
            }
            //Ahora vamos a guardar primero los mangas sin Spinn-off y despues los que si tienen
            listaMangasSinSpinOff.each { nodo ->
                def resultado = validarManga(nodo.nodoManga)
                if(resultado?.correcto){
                    if(resultado.mangaInstance.save(flush: true)){
                        if(!(validarGeneros(resultado.listOfGenders, resultado.mangaInstance))){
                            resultado.mangaInstance.delete()
                        }else{
                            numeroMangasImportados++
                        }
                    }
                }
            }

            listaMangasConSpinOff.each { nodo ->
                def resultado = validarManga(nodo.nodoManga)
                if(resultado?.correcto){
                    def validarMangaSpinOff = validarSpinOff(resultado.mangaInstance, nodo.nodoManga?.mangaSpinOff)
                    if(validarMangaSpinOff.errorSpinOff == false){
                        resultado.mangaInstance.mangaSpinOff = validarMangaSpinOff.mangaSpinOff
                        if(resultado.mangaInstance.save(flush: true)){
                            if(!(validarGeneros(resultado.listOfGenders, resultado.mangaInstance))){
                                resultado.mangaInstance.delete()
                            }else{
                                numeroMangasImportados++
                            }
                        }
                    }
                }
            }

        }else{
            log.error "No se ha podido parsear el archivo XML de los Mangas"
            codigoError = "modulos.exportacionListado.export.error.code03"
        }

        return [numeroMangasImportados: numeroMangasImportados, codigoError: codigoError]
    }

    def validarFormatoArchivo(def file){
        def correcto = true
        def extensiones = FilenameUtils.getExtension(file.originalFilename)
        //Validar si el archivo tienen formarto
        if(!extensiones.toLowerCase().equals("xml")) correcto = false

        return correcto
    }

    private def validarManga(Node manga){
        def correcto = false
        def errorSpinOff = false
        def params = []
        //Crear los objectos de Mangas
        Mangas mangaInstance = new Mangas()

        try{
            //Definir los elementos del Manga
            params =   ['autor' : Autor.findByNombreAndApellido(manga.autor?.nombreAutor, manga.autor?.apellidoAutor), 'nombreManga': manga.nombreManga,
                        'numTomosMaximos': manga.numTomosMaximos, 'precioTotal': manga?.precioTotal, 'numTomosActuales': manga.numTomosActuales,
                        'completado': Boolean.parseBoolean(manga?.completado?.text()?.toLowerCase()), 'serieAcabada': Boolean.parseBoolean(manga?.serieAcabada?.text()?.toLowerCase()),
                        'serieConsecutiva': Boolean.parseBoolean(manga?.serieConsecutiva?.text()?.toLowerCase()), 'deseado': Boolean.parseBoolean(manga?.deseado?.text()?.toLowerCase()),
                        'demografia': Demografia.findByNombre(manga.demografia?.nombreDemografia), 'listOfGenders': []]
            //Cogeremos los generos
            manga.generos.each{ genero ->
                Genero generoInstance = Genero.findByNombre(genero.nombreGenero)
                params.listOfGenders << ['id': generoInstance.id]
            }
            //Pasar el primer filtro
            if(mangasService.validateForm(params)?.error == false){
                //Pasar el segundo filtro
                if(mangasService.validateSpecificDates(params) == false){
                    //Validar coerencia de los datos Especificso y validar la logica de los datos monetarios
                    params = mangasService.validateLogic(params)
                    //Pasar el tercer filtro
                    if(mangasService.validateMonetaryData(params)?.error == false){
                        //Pasar el cuarto filtro
                        if(mangasService.validateName(params)?.error == false){
                            //pasar el quinto filtro
                            if(params.listOfGenders.size() <= Holders.config.dynaKKu.mangas.longitut.generosMax){
                                mangaInstance.properties = params
                                //Seteamos la hora
                                mangaInstance.fechaInscripcion = new SimpleDateFormat("dd-MM-yy HH:mm:ss").parse(manga?.fechaInscripcion?.text())
                                mangaInstance.ultimaModificacion = new SimpleDateFormat("dd-MM-yy HH:mm:ss").parse(manga?.ultimaModificacion?.text())
                                //Decir que ha ido bien
                                correcto = true
                            }
                        }
                    }
                }
            }
        }catch (Exception e) {
            log.error e.getMessage()
            log.error e.getCause()
        }

        return [correcto: correcto, mangaInstance: mangaInstance, listOfGenders: params.listOfGenders]
    }

    private def validarGeneros(def listOfGenders, Mangas mangaInstance){
        def validadoGeneros = true
        GenerosMangas[] listaGeneros = []
        //Validamos la existencia de los generos
        try{
            listOfGenders.each{
                GenerosMangas nuevoGenero = new GenerosMangas(mangas: mangaInstance, genero: Genero.findWhere(id: it))
                if(nuevoGenero){
                    listaGeneros << nuevoGenero
                }else{
                    validadoGeneros = false
                }
            }
        }catch (Exception e) {
            log.error e.getMessage()
            log.error e.getCause()
            validadoGeneros = false
        }

        if(validarManga()){
            listaGeneros.each { nuevoGenero ->
                if(nuevoGenero.save(flush: true)){
                    log.info "Se ha podido guardar un genero ["+ nuevoGenero.id + "] al manga ["+mangaInstance.nombreManga+"]"
                }else{
                    validadoGeneros = false
                    log.error "No se ha podido guardar un genero ["+ nuevoGenero.id + "] al manga ["+mangaInstance.nombreManga+"]"
                }
            }
        }

        return validadoGeneros
    }

    private def validarSpinOff(Mangas mangaInstance, def nombreMangaSpinOff){
        def errorSpinOff = false

        def mangaSpinOff = Mangas.findByNombreManga(nombreMangaSpinOff)
        if(mangaSpinOff){
            mangaInstance.mangaSpinOff = mangaSpinOff
        }else{
            errorSpinOff = true
        }

        return [errorSpinOff: errorSpinOff, mangaSpinOff: mangaSpinOff]
    }
}
