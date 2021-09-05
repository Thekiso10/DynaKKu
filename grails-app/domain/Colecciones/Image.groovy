package Colecciones

import grails.util.Holders

class Image {

    String id
    byte[] image
    String imageType

    static belongsTo = [imgAutor: Autor, imgManga: Mangas]

    static constraints = {
        image	    nullable:true, maxSize: Holders.config.dynaKKu.colecciones.photoSize, lazy: false
        imageType   nullable:true
    }

    static mapping = {
        id generator: "uuid", length: 32
    }

}
