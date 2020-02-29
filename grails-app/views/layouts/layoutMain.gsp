<%@ page import="Modulos.Personalizacion_Usuario.Usuario"%>

<!DOCTYPE html>
<html lang="es" class="no-js">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="DynaKKu"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<g:external dir="images/imgWeb/icons" file="favicon.ico"/>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'layoutMain.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'flashMessage.css')}" type="text/css">

		<g:if test="${Usuario.get(sec.loggedInUserInfo(['field':'id']))?.modoDark}">
			<link rel="stylesheet" href="${resource(dir: 'css', file: 'colores/nightMode.css')}" type="text/css">
		</g:if>
		<g:else>
			<link rel="stylesheet" href="${resource(dir: 'css', file: 'colores/lightMode.css')}" type="text/css">
		</g:else>

  		<asset:stylesheet src="application.css"/>
		<asset:javascript src="application.js"/>
		<g:layoutHead/>
	</head>
	<body>
		<div id="layout-container" class="container-fluid">
			%{--	Header Template	--}%
			<g:render  template="/layouts/templates/header"/>
			
			<nav id="layout-menu" class="col-sm-12">
				<div class="container">
					<div class="collapse navbar-collapse">
						<ul class="nav navbar-nav" id="BotonesColeccion">
							<li class="dropdown">
								<a href="#" class="btn btnExtra" onclick="modificarIconoMenu(this)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
									<span class="glyphicon glyphicon-chevron-down"></span><g:message code="layoutMenu.botonesColeccion.mangas"/></a>
								<ul class="dropdown-menu styleDropdown">
									<li><g:link class="btn btnMenu" controller="mangas" action="create"><g:message code="layoutMenu.botonesColeccion.mangas.crear"/></g:link></li>
									<li><g:link class="btn btnMenu" controller="mangas" action="index" params="[registrado: true]"><g:message code="layoutMenu.botonesColeccion.mangas.lista"/></g:link></li>
									<li><g:link class="btn btnMenu" controller="mangas" action="index" params="[registrado: false]"><g:message code="layoutMenu.botonesColeccion.mangas.listaDeseados"/></g:link></li>
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
									<li><g:link class="btn btnMenu" action="index" controller="historial"><g:message code="layoutMenu.botonesColeccion.funciones.historial"/></g:link></li>
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
								<g:link class="btn btnOpcions" controller="logout">
									<span class="glyphicon glyphicon-log-out"></span>
								</g:link>
							</li>
							<li>
								<button class="btn btnOpcions" id="showMe" data-toggle="modal" data-target="#modalConfiguracion">
									<span class="glyphicon glyphicon-cog"></span>
								</button>
							</li>
						</ul>
					</div>					
				</div>
			</nav>
			
			<g:layoutBody/>

			<sec:ifLoggedIn>
				<div id="modalConfiguracion" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<g:render  template="/Usuario/configuracion"/>
				</div>
			</sec:ifLoggedIn>

			<div id="spinner" class="spinner" style="display:none;">
				<img id="img-spinner" src="${resource(dir: 'images/imgWeb', file: 'spinner.gif')}" alt="Loading"/>
			</div>

		</div>
		<%-- Hacer la importacion de archivos --%>
		<g:javascript src="layoutMain.js"/>
		<g:javascript src="spinner.js"/>
	</body>
</html>
