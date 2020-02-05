package dynamiclist.Funciones

import com.itextpdf.text.Document
import grails.transaction.Transactional
import grails.util.Holders

import java.awt.Color
import java.text.SimpleDateFormat

import org.springframework.context.MessageSource

//Libreria iText
import com.itextpdf.text.BaseColor
import com.itextpdf.text.Chunk
import com.itextpdf.text.Element
import com.itextpdf.text.Font
import com.itextpdf.text.Font.FontStyle
import com.itextpdf.text.FontFactory
import com.itextpdf.text.Image
import com.itextpdf.text.List
import com.itextpdf.text.ListItem
import com.itextpdf.text.PageSize
import com.itextpdf.text.Paragraph
import com.itextpdf.text.pdf.PRTokeniser
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfPTable
import com.itextpdf.text.pdf.PdfReader
import com.itextpdf.text.pdf.PdfWriter
import com.itextpdf.text.pdf.RandomAccessFileOrArray
import com.itextpdf.text.pdf.parser.PdfReaderContentParser
import com.itextpdf.text.pdf.parser.PdfTextExtractor
import com.itextpdf.text.pdf.parser.SimpleTextExtractionStrategy
import com.itextpdf.text.pdf.parser.TextExtractionStrategy

@Transactional
class PdfService {

    static MessageSource messageSource

    def generateHistorialActividadPDF(def historialMangas, def historialAutores, def historialModulos, Locale defaultLocale, def imgBanner, def pathDoc){
        log.info "Generando PDF del Historial de Actividad"
        //Crear formato fecha actual
        def formatDate = new SimpleDateFormat("dd-MM-yyyy").format(new Date())
        //Definir el nombre del doc
        def docName = 'historialActividadPDF_'.concat(formatDate).concat('.pdf')
        //Definir variables iniciales
        Document document = new com.itextpdf.text.Document()
        //Crear documento
        try {
            //------------------ Definir propiedades del documento ------------

            //------------------ Se crea el documento -------------------------
            PdfWriter.getInstance(document,new FileOutputStream(new File(pathDoc + File.separator + docName)))
            // Se abre el documento.
            document.open()
            //------------------ Imagen de cabecera del pdf -------------------
			Image imageHeader = Image.getInstance(imgBanner)
			float scaler = ((document.getPageSize().getWidth() - document.leftMargin()- document.rightMargin()) / imageHeader.getWidth()) * 100;
            imageHeader.scalePercent(scaler)
            document.add(imageHeader)
            //------------------ Cerrar el nuevo documento --------------------
            document.close()

        }catch(Exception e){
            log.error e.getCause()
            log.error e.getMessage()
            return null
        }

        return [document: document, docName:docName]
    }
}
