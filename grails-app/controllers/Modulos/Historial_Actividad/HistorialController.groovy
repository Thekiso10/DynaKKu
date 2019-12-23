package Modulos.Historial_Actividad

class HistorialController {

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def offset = (params.offset? params.offset:0)

        render (view: 'index', model:[])
    }

    def createPDF(){
        render(view: 'createPDF', model: [])
    }

    def generateHistorialPDF() {
    }
}
