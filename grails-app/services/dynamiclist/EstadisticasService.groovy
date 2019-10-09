package dynamiclist

import grails.transaction.Transactional
import Colecciones.Autor

import java.text.DecimalFormat

@Transactional
class EstadisticasService {

    DecimalFormat formato = new DecimalFormat("#.##");

    def getMaxEdadAutor(){
        return Autor.last('edad')?.edad
    }

    def getMinEdadAutor(){
        return Autor.first('edad')?.edad
    }

    def getLastAutor(){
        return Autor.last('fechaInscripcion')
    }

    def getListAutorJoven(){
        return Autor.findAllByEdad(getMinEdadAutor())
    }

    def getListAutorMayor(){
        return Autor.findAllByEdad(getMaxEdadAutor())
    }

    def getPorAutoresMasculinos(){
        def numMasculinos = Autor.findAllByGenero('Masculino')?.size()
        return formato.format(calcularPorcentaje(numMasculinos, 0)) + "%"
    }

    def getNumAutoresMasculinos(){
        return Autor.findAllByGenero('Masculino')?.size()
    }

    def getPorAutoresFemenino(){
        def numFemenino = Autor.findAllByGenero('Femenino').size()
        return formato.format(calcularPorcentaje(numFemenino, 0)) + "%"
    }

    def getNumAutoresFemenino(){
        return Autor.findAllByGenero('Femenino')?.size()
    }

    def getPorAutoresVivos(){
        def numVivos = Autor.findAllByDifunto(false)?.size()
        return formato.format(calcularPorcentaje(numVivos, 0)) + "%"
    }

    def getNumAutoresVivos(){
        return Autor.findAllByDifunto(false)?.size()
    }

    def getPorAutoresMuertos(){
        def numMuertos = Autor.findAllByDifunto(true)?.size()
        return formato.format(calcularPorcentaje(numMuertos, 0)) + "%"
    }

    def getNumAutoresMuertos(){
        return Autor.findAllByDifunto(true)?.size()
    }

    def getNumAutores(){
        return Autor.findAll()?.size()
    }

    private def calcularPorcentaje(int valorCalc, int calc){
        int valorTotal = 0

        switch (calc){
            case 0:
                valorTotal = (Autor.findAll()?.size()?: 0)
                break
        }

        return (valorTotal > 0) ? ((valorCalc * 100) / valorTotal): 0
    }
}
