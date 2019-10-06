<!DOCTYPE html>
<html lang="es" class="no-js">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="DynamicList"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<g:external dir="images/imgWeb/icons" file="favicon.ico"/>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'layoutMain.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'flashMessage.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'colores/nightMode.css')}" type="text/css">
  		<asset:stylesheet src="application.css"/>
		<asset:javascript src="application.js"/>
		<g:layoutHead/>
	</head>
	<body>
		<div id="layout-container" class="container-fluid">
			<div id="header">
				<div class="container">
					<div id="grailsLogo" class="col-sm-12" role="banner">
						<g:link controller="estadisticas" action="index">
							<div class="col-sm-6" id="BannerLogo">
								<g:img id="LogoLayoutMain" class="col-sm-3" dir="images/imgWeb" file="LogoLayoutMain.png"/>
								<h1 class="col-sm-9"><g:message code="grailsLogo.bannerLogo.nombrePrograma"/></h1>
							</div>

							<%
								// Links idiomes
								def linkCat = request.getForwardURI()
								def linkEs = request.getForwardURI()
								def linkEn = request.getForwardURI()

								StringBuffer parametres = new StringBuffer()
								Map map = request.getParameterMap()

								for (String key: map.keySet()) {
									if (key != "lang") {
										if (map.get(key) instanceof String){
											parametres.append("&" + key + "=" + map.get(key))
										}else{
											map.get(key).each { it ->
												parametres.append("&" + key + "=" + it)
											}
										}
									}
								}

								linkCat += "?lang=ca_ES" + parametres.toString()
								linkEs  += "?lang=es" + parametres.toString()
								linkEn 	+= "?lang=en_US" + parametres.toString()
							%>

							<div class="col-sm-6" id="BannerI18n">
								<g:link url="${linkEs}"><span class="borderI18n"><g:message code="grailsLogo.bannerLogo.idiomaLink.es"/></span></g:link>
								<g:link url="${linkCat}"><span class="borderI18n"><g:message code="grailsLogo.bannerLogo.idiomaLink.cat"/></span></g:link>
								<g:link url="${linkEn}"><span><g:message code="grailsLogo.bannerLogo.idiomaLink.eng"/></span></g:link>
							</div>
						</g:link>
					</div>
				</div>
			</div>
			
			<nav id="layout-menu" class="col-sm-12">
				<div class="container">
					<div class="collapse navbar-collapse">
						<ul class="nav navbar-nav" id="BotonesColeccion">
							<li class="dropdown">
								<a href="#" class="btn btnExtra" onclick="modificarIconoMenu(this)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
									<span class="glyphicon glyphicon-chevron-down"></span><g:message code="layoutMenu.botonesColeccion.mangas"/></a>
								<ul class="dropdown-menu styleDropdown">
									<li><g:link class="btn btnMenu"><g:message code="layoutMenu.botonesColeccion.mangas.crear"/></g:link></li>
									<li><g:link class="btn btnMenu"><g:message code="layoutMenu.botonesColeccion.mangas.lista"/></g:link></li>
								</ul>	
							</li>
							<li class="dropdown">
								<a href="#" class="btn btnExtra" onclick="modificarIconoMenu(this)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
									<span class="glyphicon glyphicon-chevron-down"></span><g:message code="layoutMenu.botonesColeccion.autores"/></a>
								<ul class="dropdown-menu styleDropdown">
									<li><g:link class="btn btnMenu" action="create" controller="Autor"><g:message code="layoutMenu.botonesColeccion.autores.crear"/></g:link></li>
									<li><g:link class="btn btnMenu" action="index" controller="Autor"><g:message code="layoutMenu.botonesColeccion.autores.lista"/></g:link></li>
								</ul>	
							</li>
							<li class="dropdown">
								<a href="#" class="btn btnExtra" onclick="modificarIconoMenu(this)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
									<span class="glyphicon glyphicon-chevron-down"></span><g:message code="layoutMenu.botonesColeccion.funciones"/></a>
								<ul class="dropdown-menu styleDropdown">
									<li><g:link class="btn btnMenu" action="general" controller="Estadisticas"><g:message code="layoutMenu.botonesColeccion.funciones.stats"/></g:link></li>
									<li><g:link class="btn btnMenu"><g:message code="layoutMenu.botonesColeccion.funciones.historial"/></g:link></li>
									<li><g:link class="btn btnMenu"><g:message code="layoutMenu.botonesColeccion.funciones.GenerateReport"/></g:link></li>
								</ul>
							</li>
						</ul>
						<ul class="nav navbar-nav navbar-right" id="BotonesExtra">
							<li>
								<g:link class="btn btnExtra"><g:message code="layoutMenu.BotonesExtra.tablas"/></g:link>
							</li>
							<li>
								<g:link class="btn btnExtra"><g:message code="layoutMenu.BotonesExtra.graficas"/></g:link>
							</li>
							<li>
								<button class="btn btnOpcions">
									<span class="glyphicon glyphicon-cog"></span>
								</button>
							</li>
						</ul>
					</div>					
				</div>
			</nav>
			
			<g:layoutBody/>

			<div id="spinner" class="spinner" style="display:none;">
				<img id="img-spinner" src="${resource(dir: 'images/imgWeb', file: 'spinner.gif')}" alt="Loading"/>
			</div>

		</div>
		<%-- Hacer la importacion de archivos --%>
		<g:javascript src="layoutMain.js"/>
		<g:javascript src="spinner.js"/>
	</body>
</html>
