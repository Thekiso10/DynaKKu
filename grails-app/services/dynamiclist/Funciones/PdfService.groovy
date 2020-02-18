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
    static Locale defaultLocale
    static Document document


    def generateHistorialActividadPDF(def historialMangas, def historialAutores, def historialModulos, Locale locale, def imgBanner, def pathDoc, params){
        log.info "Generando PDF del Historial de Actividad"
        //Crear formato fecha actual
        def formatDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date())
        //Definir el nombre del doc
        def docName = 'historialActividadPDF_'.concat(formatDate).concat('.pdf')
        //Definir variables iniciales
        document = new com.itextpdf.text.Document(PageSize.A4, 36, 36, 95, 55)
        defaultLocale = locale
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
            generateCabezeraHistorialActividadPDF(params)

            if(params.allHistorial || params.tipoHistorial == '0'){
                generateHistorialMangas(params, historialMangas)
            }

            if(params.allHistorial || params.tipoHistorial == '1'){
                generateHistorialAutores(params, historialAutores)
            }

            if(params.allHistorial || params.tipoHistorial == '2'){
                generateHistorialFunciones(params, historialModulos)
            }

            //------------------ Cerrar el nuevo documento --------------------
            document.close()

        }catch(Exception e){
            log.error e.getCause()
            log.error e.getMessage()
            return null
        }

        return [document: document, docName:docName]
    }

    private def generateCabezeraHistorialActividadPDF(params){
        //Colores
        BaseColor azulOscuro    = new BaseColor (21, 32, 43)
        BaseColor blanco        = new BaseColor (255, 255, 255)
        BaseColor azulClaro     = new BaseColor (104, 200, 255)
        BaseColor azulClaro2    = new BaseColor (19, 101, 142)
        BaseColor negro         = new BaseColor (68, 68, 68)
        // Variables
        Font fontTitle = FontFactory.getFont(FontFactory.HELVETICA, 22, Font.BOLDITALIC, negro)
        Font fontSubTitle = FontFactory.getFont(FontFactory.HELVETICA, 14, Font.ITALIC | Font.UNDERLINE, negro)
        Font smallBoldWhite = FontFactory.getFont(FontFactory.HELVETICA, 10, Font.BOLD, azulClaro)
        Font smallBaseWhite = FontFactory.getFont(FontFactory.HELVETICA, 10, Font.UNDERLINE, blanco)

        def formatDate = new SimpleDateFormat("dd/MM/yyyy HH:mm a, z").format(new Date())
        //------------------- Titulo de la sesion en texto grande -----------------
        Paragraph paragraph = new Paragraph()
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
        info = new Chunk(getTypeHistorial(params, false), smallBaseWhite)
        text.add(info)
        listText << text

        text = new Paragraph((messageSource.getMessage("layoutMenu.botonesColeccion.funciones", null, defaultLocale) + ": "), smallBoldWhite)
        info = new Chunk(getFunction(params), smallBaseWhite)
        text.add(info)
        listText << text

        text = new Paragraph((messageSource.getMessage("modulos.historial.createPDF.allFunction.label", null, defaultLocale) + ": "), smallBoldWhite)
        info = new Chunk(getAllCheck(params.allFunction), smallBaseWhite)
        text.add(info)
        listText << text

        text = new Paragraph((messageSource.getMessage("modulos.historial.createPDF.pdfText.todosTipos", null, defaultLocale) + ": "), smallBoldWhite)
        info = new Chunk(getAllCheck(params.allHistorial), smallBaseWhite)
        text.add(info)
        listText << text

        text = new Paragraph((messageSource.getMessage("modulos.historial.createPDF.fecha.inicio.label", null, defaultLocale) + ": "), smallBoldWhite)
        info = new Chunk(getDate(params.startDate), smallBaseWhite)
        text.add(info)
        listText << text

        text = new Paragraph((messageSource.getMessage("modulos.historial.createPDF.fecha.final.label", null, defaultLocale) + ": "), smallBoldWhite)
        info = new Chunk(getDate(params.endDate), smallBaseWhite)
        text.add(info)
        listText << text

        listText.each {textCell ->
            cell.setPhrase(textCell)
            table.addCell(cell)
        }

        document.add(table)
        document.add(Chunk.NEWLINE)
    }

    private def generateHistorialMangas(def params, def historialMangas){
        /* Colocar titulo */
        getTitleForActivity('mangas')
        /* Setear el tipo de historial */
        params.tipoHistorial = '0'
        /* Generar bucle de actividad*/
        if(historialMangas){
            historialMangas.each{ actividad ->
                Paragraph text = generateStructureMessageBasic(params, actividad)
                def formatDate = new SimpleDateFormat("dd/MM/yyyy").format(actividad.fecha)
                // Generar el mensaje de los Autores
                
                // Colocarlo en el documento
                document.add(text)
            }
        }else{
            getTextDontRegister()
        }
    }

    private def generateHistorialAutores(def params, def historialAutores){
        /* Colocar titulo */
        getTitleForActivity('autores')
        /* Setear el tipo de historial */
        params.tipoHistorial = '1'
        /* Generar bucle de actividad*/
        if(historialAutores){
            historialAutores.each{ actividad ->
                Paragraph text = generateStructureMessageBasic(params, actividad)
                def formatDate = new SimpleDateFormat("dd/MM/yyyy").format(actividad.fecha)
                // Generar el mensaje de los Autores
                text.add(" " + messageSource.getMessage("modulos.historial.pdf.texto.autor.${actividad.tipoAccion}", [actividad?.autor?.toString(), formatDate] as Object[], defaultLocale))
                // Colocarlo en el documento
                document.add(text)
            }
        }else{
            getTextDontRegister()
        }

    }

    private def generateHistorialFunciones(def params, def historialModulos){
        /* Colocar titulo */
        getTitleForActivity('modulos')
        /* Setear el tipo de historial */
        params.tipoHistorial = '2'
        /* Generar bucle de actividad*/
        if(historialModulos){
            historialModulos.each{ actividad ->
                Paragraph text = generateStructureMessageBasic(params, actividad)
                def formatDate = new SimpleDateFormat("dd/MM/yyyy").format(actividad.fecha)
                // Generar el mensaje de los Autores

                //TODO: Pendiente de integrar

                // Colocarlo en el documento
                document.add(text)
            }
        }else{
            getTextDontRegister()
        }
    }

    private def generateStructureMessageBasic(def params, def actividad){
        //Colores
        BaseColor azul01  = new BaseColor (13, 52, 78)
        BaseColor azul02  = new BaseColor (42, 52, 62)
        //Fuentes
        Font fontChuck = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD, azul02)
        Font fontText01 = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD, azul01)
        //Logica de la estructura basica
        Chunk chunk = new Chunk("", fontChuck)
        chunk.setUnderline(2f, -4f)
        Paragraph text = new Paragraph("", fontText01)
        text.setSpacingAfter(10)
        //Formatear tabulación
        text.add(Chunk.TABBING)
        //Formatar bloque del tiempo
        def formatDate = new SimpleDateFormat("dd-MM-yyyy HH:mm a, z").format(actividad.fecha)
        def textoData = "[" + formatDate +"]"
        chunk.append(textoData)
        //Formatar bloque de clases
        def textoClase = "[" + getTypeHistorial(params, true) +"]"
        chunk.append(textoClase)
        //El tipo de funcion
        def textoFuncion = "[" + messageSource.getMessage("modulos.historial.label.${actividad.tipoAccion}", null, defaultLocale) +"]"
        chunk.append(textoFuncion)
        //Colocar textos en el PDF
        text.add(chunk)

        return text
    }

    /* Funciones pequenas para los 'generate' */

    private def getTypeHistorial(params, def getType){
        def text

        if(params.allHistorial && !getType){
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

    private def getFunction(params){
        def text

        if(params.allHistorial || params.allFunction){
            text = messageSource.getMessage("modulos.historial.createPDF.pdfText.allFunction", null, defaultLocale)
        }else{
            text = messageSource.getMessage("modulos.historial.label.${params.function}", null, defaultLocale)
        }

        return text
    }

    private def getAllCheck(def check) {
        if(check){
            return (messageSource.getMessage("default.si.label", null, defaultLocale))
        }else{
            return (messageSource.getMessage("default.no.label", null, defaultLocale))
        }
    }

    private def getDate(def date) {
        if(date){
            return date
        }else {
            return (messageSource.getMessage("modulos.historial.createPDF.fecha.noIndicado.label", null, defaultLocale))
        }
    }

    private def getTitleForActivity(def typeTitle){
        //Colores
        BaseColor negro = new BaseColor (68, 68, 68)
        // Variables
        Font fontTitle = FontFactory.getFont(FontFactory.HELVETICA, 20, Font.NORMAL, negro)
        /* Colocar titulo */
        Paragraph title = new Paragraph()
        title.setFont(fontTitle)
        title.add(messageSource.getMessage(("modulos.historial.pdf.title." + typeTitle), null, defaultLocale))
        title.setSpacingBefore(40f)
        title.setSpacingAfter(15f)
        document.add(title)
    }

    private def getTextDontRegister() {
        //Colores
        BaseColor negro = new BaseColor (68, 68, 68)
        //Fuentes
        Font fontSubTitle = FontFactory.getFont(FontFactory.HELVETICA, 14, Font.ITALIC | Font.UNDERLINE, negro)
        //texto
        Paragraph subTitle = new Paragraph()
        subTitle.setFont(fontSubTitle)
        subTitle.add(messageSource.getMessage("modulos.historial.createPDF.pdfText.noRegistro", null, defaultLocale))
        subTitle.setAlignment(Element.ALIGN_CENTER)
        subTitle.setSpacingBefore(20f)
        document.add(subTitle)
    }

}
