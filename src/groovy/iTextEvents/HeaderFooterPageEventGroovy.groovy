package iTextEvents


import com.itextpdf.text.Rectangle;
import com.itextpdf.text.BaseColor
import com.itextpdf.text.DocumentException
import com.itextpdf.text.Element
import com.itextpdf.text.ExceptionConverter
import com.itextpdf.text.Font
import com.itextpdf.text.Image
import com.itextpdf.text.Phrase
import com.itextpdf.text.pdf.PdfContentByte
import com.itextpdf.text.pdf.PdfPageEventHelper
import com.itextpdf.text.pdf.PdfTemplate
import com.itextpdf.text.pdf.PdfWriter
import com.itextpdf.text.Document
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfPTable
import com.itextpdf.text.pdf.ColumnText
import com.itextpdf.text.pdf.PdfName

import org.codehaus.groovy.grails.web.servlet.mvc.GrailsWebRequest
import org.codehaus.groovy.grails.web.util.WebUtils

import java.text.SimpleDateFormat

class HeaderFooterPageEventGroovy extends PdfPageEventHelper{
    private PdfTemplate t;
    private Image total;
    private String nombreAplicacion;

    public HeaderFooterPageEventGroovy(def nombreAplicacion) {
        this.nombreAplicacion = nombreAplicacion;
    }

    void onOpenDocument(PdfWriter writer, Document document) {
        t = writer.getDirectContent().createTemplate(30, 16);
        try {
            total = Image.getInstance(t);
            total.setRole(PdfName.ARTIFACT);
        } catch (DocumentException de) {
            throw new ExceptionConverter(de);
        }
    }

    @Override
    void onEndPage(PdfWriter writer, Document document) {
        addHeader(writer);
        addFooter(writer);
    }

    private void addHeader(PdfWriter writer){
        PdfPTable header = new PdfPTable(2);
        try {
            // set defaults
            int[] widths = [2, 24].toArray()
            header.setWidths(widths)
            header.setTotalWidth(527)
            header.setLockedWidth(false);
            header.getDefaultCell().setFixedHeight(40);
            header.getDefaultCell().setBorder(Rectangle.BOTTOM);
            header.getDefaultCell().setBorderColor(new BaseColor(19, 101, 142));

            // add image

            GrailsWebRequest webUtils = WebUtils.retrieveGrailsWebRequest()
            def request = webUtils.getCurrentRequest()
            def img = request.getSession().getServletContext().getRealPath("/images/imgWeb/pdf/headerPDF.png")

            Image logo = Image.getInstance(img)
            header.addCell(logo);
            // set Date
            String formatDate = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss a, z").format(new Date());
            String textSecundario = "PDF generado el dia ".concat(formatDate);

            // add text
            PdfPCell text = new PdfPCell();
            text.setPaddingBottom(15);
            text.setPaddingLeft(5);
            text.setBorder(Rectangle.BOTTOM);
            text.setBorderColor(new BaseColor(19, 101, 142));
            text.addElement(new Phrase("Informe generado por ".concat(this.nombreAplicacion), new Font(Font.FontFamily.HELVETICA, 12)));
            text.addElement(new Phrase("PDF generado el dia " + formatDate, new Font(Font.FontFamily.HELVETICA, 8)));
            header.addCell(text);

            // write content
            header.writeSelectedRows(0, -1, 34, 803, writer.getDirectContent());
        } catch(DocumentException de) {
            throw new ExceptionConverter(de);
        } catch (MalformedURLException e) {
            throw new ExceptionConverter(e);
        } catch (IOException e) {
            throw new ExceptionConverter(e);
        }
    }

    private void addFooter(PdfWriter writer){
        PdfPTable footer = new PdfPTable(3);
        try {
            // set defaults
            int[] widths = [24, 2, 1].toArray()
            footer.setWidths(widths);
            footer.setTotalWidth(527);
            footer.setLockedWidth(true);
            footer.getDefaultCell().setFixedHeight(40);
            footer.getDefaultCell().setBorder(Rectangle.TOP);
            footer.getDefaultCell().setBorderColor(new BaseColor(19, 101, 142));

            // add copyright
            footer.addCell(new Phrase("\u00A9".concat(this.nombreAplicacion)+" - Generación de información", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD)));

            // add current page count
            footer.getDefaultCell().setHorizontalAlignment(Element.ALIGN_RIGHT);
            footer.addCell(new Phrase(String.format("Page %d of", writer.getPageNumber()), new Font(Font.FontFamily.HELVETICA, 8)));

            // add placeholder for total page count
            PdfPCell totalPageCount = new PdfPCell(total);
            totalPageCount.setBorder(Rectangle.TOP);
            totalPageCount.setBorderColor(new BaseColor(19, 101, 142));
            footer.addCell(totalPageCount);

            // write page
            PdfContentByte canvas = writer.getDirectContent();
            canvas.beginMarkedContentSequence(PdfName.ARTIFACT);
            footer.writeSelectedRows(0, -1, 34, 50, canvas);
            canvas.endMarkedContentSequence();
        } catch(DocumentException de) {
            throw new ExceptionConverter(de);
        }
    }

    void onCloseDocument(PdfWriter writer, Document document) {
        int totalLength = String.valueOf(writer.getPageNumber()).length();
        int totalWidth = totalLength * 5;
        ColumnText.showTextAligned(t, Element.ALIGN_RIGHT,
                new Phrase(String.valueOf(writer.getPageNumber()), new Font(Font.FontFamily.HELVETICA, 8)),
                totalWidth, 6, 0);
    }
}
