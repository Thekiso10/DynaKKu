package API

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

class ApiController {

    @Secured (['ROLE_ADMIN', 'ROLE_WS'])
    def getVersion() {
        def version = ['versión': grailsApplication.config.dynaKKu.version.app]
        render (status: 200, text: version as JSON, contentType: "application/json")
    }
}
