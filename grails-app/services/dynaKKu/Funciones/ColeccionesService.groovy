package dynaKKu.Funciones

import Colecciones.Image
import grails.transaction.Transactional
import grails.util.Holders
import org.apache.commons.io.FilenameUtils

@Transactional
class ColeccionesService {

    //Eliminar la foto
    def deleteImage(def path){
        def error = false

        try{
            def file = new File(path)
            file.delete()
            log.info "Se ha borrado correctamente la foto"
        }catch (Exception e){
            error = true
            log.error "No se ha borrado correctamente la foto"
        }

        return error
    }

    def saveImgWithBBDD(def img){
        def error = false
        def mensaje = null
        Image imageInstance = new Image()

        if(img?.getBytes()?.size()){
            def extensiones = FilenameUtils.getExtension(img.originalFilename)
            if(!extensiones.toLowerCase().equals("jpg") && !extensiones.toLowerCase().equals("jpeg") && !extensiones.toLowerCase().equals("png")){
                error = true
                mensaje = "autores.errores.img.formato"
                log.error "Han intentado introducir un formato invalido de imagen [" + extensiones + "]"
            }else {
                imageInstance.image = img.getBytes()
                imageInstance.imageType = img.getContentType()
            }
        }else{
            error = true
            log.error "[Colecciones] Validar rutas de la foto a fallado."
        }

        return [error: error, imageInstance: imageInstance, mensaje: mensaje]
    }

    //Guardar la foto
    def saveImgWithServer(def foto, def nombre, def nombre02, def mangas){
        def error = false
        def path = null
        def mensaje = null

        File carpeta = new File((!mangas ? Holders.config.dynaKKu.autores.rutaImg : Holders.config.dynaKKu.mangas.rutaImg))

        if(!foto.empty && carpeta.exists()){
            def extensiones = FilenameUtils.getExtension(foto.originalFilename)

            if(!extensiones.toLowerCase().equals("jpg") && !extensiones.toLowerCase().equals("jpeg") && !extensiones.toLowerCase().equals("png")){
                error = true
                mensaje = "autores.errores.img.formato"
                log.error "Han intentado introducir un formato invalido de imagen [" + extensiones + "]"
            }else{
                try{
                    def nombreAuthor = (!mangas ? (nombre + "_" + nombre02) : nombre)
                    path = carpeta.getAbsolutePath() + File.separator + nombreAuthor + "." + extensiones
                    foto.transferTo(new File(path))
                }catch (Exception e){
                    error = true
                    mensaje = "autores.errores.img.saveFolder"
                    log.error e
                }
            }
        }else{
            error = true
            log.error "[Colecciones] Validar rutas de la foto a fallado."
        }

        return [error:error, mensaje:mensaje, path:path]
    }
    /* Cambiar nombre de las imagenes */
    def changeNameImg(def urlImg, def nombre, def mangas) {
        def error = false
        def path = urlImg

        File foto = new File(urlImg)
        File carpeta = new File((!mangas ? Holders.config.dynaKKu.autores.rutaImg : Holders.config.dynaKKu.mangas.rutaImg))

        if (foto.exists() && foto.isFile()) {
            try {
                def extensiones = FilenameUtils.getExtension(foto.absolutePath)
                def nombreAuthor = nombre
                path = carpeta.getAbsolutePath() + File.separator + nombreAuthor + "." + extensiones
                foto.renameTo(new File(path))
            } catch (Exception e) {
                error = true
                log.error e
            }
        } else {
            error = true
            log.error "[Colecciones] Validar ruta de la foto a fallado."
        }

        return [error:error, path:path]
    }
}
