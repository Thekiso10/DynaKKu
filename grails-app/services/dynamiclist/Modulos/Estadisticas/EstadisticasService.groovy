package dynamiclist.Modulos.Estadisticas

import grails.transaction.Transactional
import Colecciones.Autor

import java.text.DecimalFormat

@Transactional
class EstadisticasService {

    DecimalFormat formato = new DecimalFormat("#.##");

    def getMaxEdadAutor(){
        return Autor.findByBorrado(false, [sort: 'edad', order: "desc"])?.edad
    }

    def getMinEdadAutor(){
        Autor.findByBorrado(false, [sort: 'edad', order: "asc"])?.edad
    }

    def getLastAutor(){
        Autor.findByBorrado(false, [sort: 'fechaInscripcion', order: "desc"])
    }

    def getListAutorJoven(){
        return Autor.findAllByEdad(getMinEdadAutor())
    }

    def getListAutorMayor(){
        return Autor.findAllByEdad(getMaxEdadAutor())
    }

    def getPorAutoresMasculinos(){
        def numMasculinos = Autor.findAllByGeneroAndBorrado('Masculino', false)?.size()
        return formato.format(calcularPorcentaje(numMasculinos, 0)) + "%"
    }

    def getNumAutoresMasculinos(){
        return Autor.findAllByGeneroAndBorrado('Masculino', false)?.size()
    }

    def getPorAutoresFemenino(){
        def numFemenino = Autor.findAllByGeneroAndBorrado('Femenino', false).size()
        return formato.format(calcularPorcentaje(numFemenino, 0)) + "%"
    }

    def getNumAutoresFemenino(){
        return Autor.findAllByGeneroAndBorrado('Femenino', false)?.size()
    }

    def getPorAutoresVivos(){
        def numVivos = Autor.findAllByDifuntoAndBorrado(false, false)?.size()
        return formato.format(calcularPorcentaje(numVivos, 0)) + "%"
    }

    def getNumAutoresVivos(){
        return Autor.findAllByDifuntoAndBorrado(false, false)?.size()
    }

    def getPorAutoresMuertos(){
        def numMuertos = Autor.findAllByDifuntoAndBorrado(true, false)?.size()
        return formato.format(calcularPorcentaje(numMuertos, 0)) + "%"
    }

    def getNumAutoresMuertos(){
        return Autor.findAllByDifuntoAndBorrado(true, false)?.size()
    }

    def getNumAutores(){
        return Autor.findAllByBorrado(false)?.size()
    }

    private def calcularPorcentaje(int valorCalc, int calc){
        int valorTotal = 0

        switch (calc){
            case 0:
                valorTotal = (Autor.findAllByBorrado(false)?.size()?: 0)
                break
        }

        return (valorTotal > 0) ? ((valorCalc * 100) / valorTotal): 0
    }
}
