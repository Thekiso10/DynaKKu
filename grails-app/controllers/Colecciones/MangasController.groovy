package Colecciones

import Colecciones.Mangas
import Colecciones.GenerosMangas

class MangasController {

    def mangasService

    def index() {

    }

    def create() {
        respond new Mangas(params)
    }
}
