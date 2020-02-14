package dynamiclist.Funciones

import com.itextpdf.text.Document
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfPTable
import dynamiclist.Funciones.ClasesJavaPDF.HeaderFooterPageEvent

import grails.transaction.Transactional

import java.text.SimpleDateFormat

import org.springframework.context.MessageSource

//Libreria iText
import com.itextpdf.text.BaseColor
import com.itextpdf.text.Chunk
import com.itextpdf.text.Element
import com.itextpdf.text.Font
import com.itextpdf.text.FontFactory
import com.itextpdf.text.Image
import com.itextpdf.text.PageSize
import com.itextpdf.text.Paragraph
import com.itextpdf.text.pdf.PdfWriter

@Transactional
class PdfService {

    static MessageSource messageSource

    def generateHistorialActividadPDF(def historialMangas, def historialAutores, def historialModulos, Locale defaultLocale, def imgBanner, def pathDoc, params){
        log.info "Generando PDF del Historial de Actividad"
        //Crear formato fecha actual
        def formatDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date())
        //Definir el nombre del doc
        def docName = 'historialActividadPDF_'.concat(formatDate).concat('.pdf')
        //Definir variables iniciales
        Document document = new com.itextpdf.text.Document(PageSize.A4, 36, 36, 90, 36)
        //Crear documento
        try {
            //------------------ Se crea el documento -------------------------
            PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(new File(pathDoc + File.separator + docName)))
            //------------------ Setear tanto el Headre como Footer -----------
            HeaderFooterPageEvent event = new HeaderFooterPageEvent()
            writer.setPageEvent(event)
            // Se abre el documento
            document.open()
            //Document metadata
            document.addTitle('Historial de Actividad - '.concat(formatDate));
            document.addSubject(docName);
            //------------------ Imagen de cabecera del pdf -------------------
			Image imageHeader = Image.getInstance(imgBanner)
			float scaler = ((document.getPageSize().getWidth() - document.leftMargin()- document.rightMargin()) / imageHeader.getWidth()) * 100
            imageHeader.scalePercent(scaler)
            document.add(imageHeader)
            //------------------ Ejecutar logica ------------------------------
            //Colocar la cabezera informativa
            getCabezeraHistorialActividadPDF(document, defaultLocale, params)

            if(historialAutores){

            }

            if(historialMangas){

            }

            if(historialModulos){

            }

            if(!historialMangas && !historialAutores && !historialModulos){
                //TODO: Hay que imprimir un titulo que indique no hay registros
            }

            //------------------ Cerrar el nuevo documento --------------------
            document.close()

        }catch(Exception e){
            log.error e.getCause()
            log.error e.getMessage()
            e.printStackTrace()
            return null
        }

        return [document: document, docName:docName]
    }

    private def getCabezeraHistorialActividadPDF(Document document, Locale defaultLocale, params){
        //Colores
        BaseColor azulOscuro    = new BaseColor (21, 32, 43)
        BaseColor blanco        = new BaseColor (255, 255, 255)
        BaseColor azulClaro     = new BaseColor (104, 200, 255)
        BaseColor azulClaro2    = new BaseColor (19, 101, 142)
        BaseColor negro         = new BaseColor (68, 68, 68)
        // Variables
        Paragraph paragraph = new Paragraph()
        Font fontTitle = FontFactory.getFont(FontFactory.HELVETICA, 18, Font.BOLDITALIC, negro)
        Font fontSubTitle = FontFactory.getFont(FontFactory.HELVETICA, 14, Font.ITALIC | Font.UNDERLINE, negro)
        Font smallBoldWhite = FontFactory.getFont(FontFactory.HELVETICA, 10, Font.BOLD, azulClaro)
        Font smallBaseWhite = FontFactory.getFont(FontFactory.HELVETICA, 10, Font.UNDERLINE, blanco)

        def formatDate = new SimpleDateFormat("dd/MM/yyyy HH:mm a, z").format(new Date())
        //------------------- Titulo de la sesion en texto grande -----------------
        paragraph.setFont(fontTitle)
        paragraph.add('Historial de Actividad - '.concat(formatDate))
        paragraph.setAlignment(Element.ALIGN_CENTER)
        paragraph.setSpacingAfter(25f)
        document.add(paragraph)
        //------------------- Bloque de informacion del filtro --------------------
        Paragraph subtitle = new Paragraph()
        subtitle.setFont(fontSubTitle)
        subtitle.setAlignment(Element.ALIGN_CENTER)
        subtitle.add("Parametros de generacion - Historial de Actividad")
        subtitle.setSpacingAfter(12.5f)
        document.add(subtitle)
        //document.add(Chunk.NEWLINE)

        //Definir la propiedades de la tabla
        PdfPTable table = new PdfPTable(3)
        table.setWidthPercentage(100)
        //Definir las cellas
        PdfPCell cell = new PdfPCell()
        cell.setHorizontalAlignment(Element.ALIGN_CENTER)
        cell.setVerticalAlignment(Element.ALIGN_CENTER)
        cell.setBackgroundColor(azulOscuro)
        cell.setBorderColor(azulClaro2)
        cell.setPaddingTop(6)
        cell.setPaddingBottom(10)
        //Setear texto
        def text
        def info
        def listText = []

        text = new Paragraph((messageSource.getMessage("modulos.historial.createPDF.tipoHistorial.label", null, defaultLocale) + ": "), smallBoldWhite)
        info = new Chunk(getTypeHistorial(params, defaultLocale), smallBaseWhite)
        text.add(info)
        listText << text

        text = new Paragraph((messageSource.getMessage("layoutMenu.botonesColeccion.funciones", null, defaultLocale) + ": "), smallBoldWhite)
        info = new Chunk(getFunction(params, defaultLocale), smallBaseWhite)
        text.add(info)
        listText << text

        text = new Paragraph((messageSource.getMessage("modulos.historial.createPDF.allFunction.label", null, defaultLocale) + ": "), smallBoldWhite)
        info = new Chunk(getAllCheck(params.allFunction, defaultLocale), smallBaseWhite)
        text.add(info)
        listText << text

        text = new Paragraph((messageSource.getMessage("modulos.historial.createPDF.pdfText.todosTipos", null, defaultLocale) + ": "), smallBoldWhite)
        info = new Chunk(getAllCheck(params.allHistorial, defaultLocale), smallBaseWhite)
        text.add(info)
        listText << text

        text = new Paragraph((messageSource.getMessage("modulos.historial.createPDF.fecha.inicio.label", null, defaultLocale) + ": "), smallBoldWhite)
        info = new Chunk(getDate(params.startDate, defaultLocale), smallBaseWhite)
        text.add(info)
        listText << text

        text = new Paragraph((messageSource.getMessage("modulos.historial.createPDF.fecha.final.label", null, defaultLocale) + ": "), smallBoldWhite)
        info = new Chunk(getDate(params.endDate, defaultLocale), smallBaseWhite)
        text.add(info)
        listText << text

        listText.each {textCell ->
            cell.setPhrase(textCell)
            table.addCell(cell)
        }

        document.add(table)
    }

    private def getTypeHistorial(params, Locale defaultLocale){
        def text

        if(params.allHistorial){
            text = messageSource.getMessage("modulos.historial.createPDF.pdfText.todosTipos", null, defaultLocale)
        }else if (params.tipoHistorial == '0') {
            text = messageSource.getMessage("layoutMenu.botonesColeccion.mangas", null, defaultLocale)
        }else if (params.tipoHistorial == '1') {
            text = messageSource.getMessage("layoutMenu.botonesColeccion.autores", null, defaultLocale)
        }else if (params.tipoHistorial == '2') {
            text = messageSource.getMessage("layoutMenu.botonesColeccion.funciones", null, defaultLocale)
        }

        return text
    }

    private def getFunction(params, Locale defaultLocale){
        def text

        if(params.allHistorial || params.allFunction){
            text = messageSource.getMessage("modulos.historial.createPDF.pdfText.allFunction", null, defaultLocale)
        }else if (params.function == 'CREACION') {
            text = messageSource.getMessage("modulos.historial.create.label", null, defaultLocale)
        }else if (params.function == 'CONSULTA') {
            text = messageSource.getMessage("modulos.historial.show.label", null, defaultLocale)
        }else if (params.function == 'ACTUALIZACION') {
            text = messageSource.getMessage("modulos.historial.update.label", null, defaultLocale)
        }else if (params.function == 'ELIMINACION') {
            text = messageSource.getMessage("modulos.historial.delete.label", null, defaultLocale)
        }else if(params.function == 'ADD_TOMOS') {
            text = messageSource.getMessage("modulos.historial.addTomos.label", null, defaultLocale)
        }else if(params.function == 'ADD_SPIN_OFF') {
            text = messageSource.getMessage("modulos.historial.addSpinOff.label", null, defaultLocale)
        }else if(params.function == 'PASS_REGISTRADO') {
            text = messageSource.getMessage("modulos.historial.passRegister.label", null, defaultLocale)
        }else if(params.function == 'DELETE_SPIN_OFF') {
            text = messageSource.getMessage("modulos.historial.deleteSpinOff.label", null, defaultLocale)
        }else if(params.function == 'ESTADISTICAS') {
            text = messageSource.getMessage("stats.header.title.general.label", null, defaultLocale)
        }else if(params.function == 'HISTORIAL_ACTIVIDAD') {
            text = messageSource.getMessage("modulos.historial.actividad.lable", null, defaultLocale)
        }else if(params.function == 'EXPORTACION_LISTADO') {
            text = messageSource.getMessage("modulos.exportacionListado.title", null, defaultLocale)
        }else if(params.function == 'LISTADO_PDF') {
            text = messageSource.getMessage("modulos.listadoPDF.title", null, defaultLocale)
        }else if(params.function == 'REPOSRTE_PDF') {
            text = messageSource.getMessage("modulos.reportes.title", null, defaultLocale)
        }

        return text
    }

    private def getAllCheck(def check, Locale defaultLocale) {
        if(check){
            return (messageSource.getMessage("default.si.label", null, defaultLocale))
        }else{
            return (messageSource.getMessage("default.no.label", null, defaultLocale))
        }
    }

    private def getDate(def date, Locale defaultLocale) {
        if(date){
            return date
        }else {
            return (messageSource.getMessage("modulos.historial.createPDF.fecha.noIndicado.label", null, defaultLocale))
        }
    }
}
