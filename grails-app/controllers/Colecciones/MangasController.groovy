package Colecciones

import Colecciones.Mangas
import Colecciones.GenerosMangas

class MangasController {

    def mangasService

    def index() {

    }

    def create() {
        def hayAutores = (Autor.list()?.size() > 0)? true : false //Buscamo si hay autores
        respond new Mangas(params), model:[hayAutores:hayAutores]
    }
}
