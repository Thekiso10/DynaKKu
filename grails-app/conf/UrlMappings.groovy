class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

		"/"(view:'estadisticas/general')
		//Redireccionar a las vistas de errores		
        "500"(view:'/error')
		"404"(view:'/error404')
	}
}
