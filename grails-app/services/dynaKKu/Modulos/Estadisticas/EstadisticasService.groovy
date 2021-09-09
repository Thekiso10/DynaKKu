package dynaKKu.Modulos.Estadisticas

import grails.transaction.Transactional

@Transactional
class EstadisticasService {

    def mangasService

    def getPercentCompletedTomosMangas(){
        def getValueTomos = mangasService.getValueTomosMangas()
        return [percent: calcPercent(getValueTomos.tomosMaximos, getValueTomos.tomosActuales), tomosMaximos: getValueTomos.tomosMaximos, tomosActuales: getValueTomos.tomosActuales]
    }

    def getPercentCompletedMangas(){
        def getValueMangas = mangasService.getValueMangasCompletos()
        return [percent: calcPercent(getValueMangas.totalMangas, getValueMangas.numMangasCompletos), numMangasCompletos: getValueMangas.numMangasCompletos]
    }

    private def calcPercent(int total, int num){
        return (total > 0) ? ((num * 100) / total): 0
    }

}
