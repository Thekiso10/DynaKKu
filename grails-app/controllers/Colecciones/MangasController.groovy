package Colecciones

import Colecciones.Mangas
import Colecciones.GenerosMangas
import grails.transaction.Transactional
import org.fusesource.jansi.AnsiRenderer

class MangasController {

    def mangasService
    def autorService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def mangasInstanceList = []
        def registrados = params.registrado.equals("true") ? true : false
        def mangasListaTotal = Mangas.list(params)
        def offset = (params.offset? params.offset : 0)
        //Vamos a desgranar la lista en funcion de la variable registrados
        mangasListaTotal.each {manga ->
            if(manga.deseado == !registrados){
                mangasInstanceList << manga
            }
        }
        //Buscamos el numero de mangas despues de desgranar
        def mangasInstanceCount = Mangas.findAllByDeseado(!registrados).size()
        //Miramos si hace falta usar el filtro
        if(params.search){

            if(params.nombreManga || params.autor) { //Para que no se de al filtro con los tres campos vacios
                def numTomos = 0
                if(registrados && params.numTomos){ //Validamos el parametro de numero de tomos por separado por si es un manga deseado o registrado
                    numTomos = params.numTomos
                }

                def magasFiltro = Mangas.createCriteria()
                def mangasList = magasFiltro.list (max: params.max, offset:offset){ //Para la paginacion
                    ilike ("nombreManga", ("%" + params.nombreManga.toString() + "%"))
                    eq("deseado", !registrados)
                    if(params.numTomos){ //Por si el campo viene vacio
                        eq ("numTomosActuales", Integer.parseInt(params.numTomos.toString()))
                    }
                }

                mangasInstanceList = mangasList
                mangasInstanceCount = mangasInstanceList.totalCount

                if(listaFiltro.size() != 0) {
                    flash.message = message(code: "default.filter.resultados.label", args:[mangasInstanceCount, message(code: "layoutMenu.botonesColeccion.mangas")])
                }else{
                    flash.message = message(code: "default.list.notSize", args:[message(code: "layoutMenu.botonesColeccion.mangas")])
                }
            }
        }else{
            log.info "Se ha ejecutado la limpieza del filtro de Mangas"
            //Ejecutar la limpieza de los parametros del filtro
            params.nombreManga 	= ""
            params.autor        = ""
            params.numTomos 	= ""
        }

        if(mangasInstanceCount == 0){
            flash.warn = message(code: "default.list.notSize", args:[message(code: "layoutMenu.botonesColeccion.mangas")])
        }

        respond mangasInstanceList, model: [mangasInstanceCount: mangasInstanceCount, mangasRegistrados: registrados]
    }

    def create() {
        def hayAutores = (Autor.list()?.size() > 0)? true : false //Buscamo si hay autores
        respond new Mangas(params), model:[hayAutores:hayAutores]
    }

    @Transactional
    def save(Mangas mangasInstance){
        //Comprobar que existe un Autor con el ID de la vista
        if(!(Autor.findWhere(id: params.autor.id))){
            log.error "Estan intentando crear un manga sin un id de Autor valido"
            flash.error = message(code: "mangas.error.autor.dontId")
            redirect(action: "create")
            return
        }
        //Comprobar que los campos de Datos generales, Generos y Demografia no sean nullos o vacios
        //Tambien comporbamos que los datos monetarios no sean negativos
        def validarForm = mangasService.validateForm(params)
        if(validarForm.error){
            flash.error = message(code: validarForm.mensaje)
            redirect(action: "create")
            return
        }
        //Validar Datos Especificos
        def validarDatosEspecificos = mangasService.validateSpecificDates(params)
        if(validarDatosEspecificos.error){
            flash.error = message(code: validarDatosEspecificos.mensaje)
            redirect(action: "create")
            return
        }
        //Validar la logica de los datos monetarios
        if(params.deseado){
            /*
                No puede haber tomos en propieda
                Puede ser 0 en el precio por tomo
            */
            if(Integer.parseInt(params.numTomosActuales) >= 1){
                log.warn "Estan intentando crear un manga deseado con numero de tomos actuales mayor de 0"
                params.numTomosActuales = '0'
            }
        }else if(params.completado){
            /*
               Los tomos en propiedad y tomos totales tienen que ser iguales.
               Si no lo son, se le coloca el mismo valor a los tomos en propiedad.
               No puede ser 0 en el precio por tomo
            */
            //Validar que el numero de tomos maximos no sea 0
            if(Integer.parseInt(params.numTomosMaximos) == 0){
                flash.error = message(code: 'mangas.error.especificos.tomosTotales.menos')
                redirect(action: "create")
                return
            }

            if(Integer.parseInt(params.numTomosMaximos) != Integer.parseInt(params.numTomosActuales)){
                log.warn "Estan intentando crear un manga completado con diferentes numTomosMaximos y numTomosActuales"
                params.numTomosActuales = params.numTomosMaximos
            }
        }
        //Comprobar logica con los Datos Especificos con respecto a los Datos monetarios
        def validarDatosMonetarios = mangasService.validateMonetaryData(params)
        if(validarDatosMonetarios.error){
            flash.error = message(code: validarDatosMonetarios.mensaje)
            redirect(action: "create")
            return
        }
        //Comprobar longitut del nombre y si ya existe uno manga con el mismo nombre
        def validarNombreManga = mangasService.validateName(params)
        if(validarNombreManga.error){
            flash.error = message(code: validarNombreManga.mensaje)
            redirect(action: "create")
            return
        }
        //Si hay foto guardarla en la carpeta configurada
        def file = request.getFile('imagen')
        def validarFoto
        if(!file.empty){
            validarFoto = mangasService.saveImg(file, params.nombreManga)
            if (validarFoto.error) {
                flash.error = message(code: validarFoto.mensaje)
                redirect(action: "create")
                return
            }
            mangasInstance.urlImg = validarFoto.path
        }

        //Inicializaremos los valores de la instancia
        mangasInstance.nombreManga = params.nombreManga
        mangasInstance.autor = Autor.findWhere(id: params.autor.id)
        mangasInstance.serieAcabada = (params.serieAcabada? true : false)
        mangasInstance.serieConsecutiva = (params.serieConsecutiva? true : false)
        mangasInstance.completado = (params.completado? true : false)
        mangasInstance.deseado = (params.deseado? true : false)
        mangasInstance.numTomosActuales = Integer.parseInt(params.numTomosActuales)
        mangasInstance.numTomosMaximos = Integer.parseInt(params.numTomosMaximos)
        mangasInstance.precioTotal = Integer.parseInt(params.precioTotal)
        mangasInstance.demografia = Demografia.findWhere(id: params.demografia.nombre)
        mangasInstance.fechaInscripcion = new Date()
        mangasInstance.ultimaModificacion = new Date()
        //Guardar la instancia
        try{
            if(mangasInstance.save(flush:true)){
                log.info "Se ha podido crear un nuevo manga"

                params.listOfGenders.split(',').each{
                    GenerosMangas nuevoGenero = new GenerosMangas(mangas: mangasInstance, genero: Genero.findWhere(id: it))
                    if(nuevoGenero.save(flush: true)){
                        log.info "Se ha podido guardar un genero ["+ it + "] al manga ["+mangasInstance.nombreManga+"]"
                    }else{
                        log.error "No se ha podido guardar un genero ["+ it + "] al manga ["+mangasInstance.nombreManga+"]"
                    }
                }

                flash.message = message(code: "mangas.message.save.ok", args: [mangasInstance.nombreManga])
            }else{
                if(validarFoto?.path)autorService.deleteImage(validarFoto.path)
                log.info "No se ha podido crear un nuevo manga"
                flash.error = message(code: "mangas.errores.save.bbdd")
                redirect(action: "create")
                return
            }
        }catch(Exception e){
            log.error "No se ha podido guardar en base de datos: " + e
            flash.error = message(code: "mangas.errores.save.bbdd")
            redirect(action: "create")
            return
        }


        redirect(action:"show", id:mangasInstance.id)
    }

    @Transactional
    def show(Mangas mangasInstance) {
        respond mangasInstance
    }
}