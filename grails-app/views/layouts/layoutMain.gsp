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
	<body class="is-preload">
		<div id="wrapper">

			<!-- Main -->
			<div id="main">
				<div class="inner">
					%{--	Header Template	--}%
					<g:render  template="/layouts/templates/header"/>

				</div>
			</div>

			<div id="sidebar">
				<div class="inner">
					<g:render  template="/layouts/templates/naving"/>
				</div>
			</div>

			<g:link class="btn btnOpcions" controller="logout">
				<span class="glyphicon glyphicon-log-out"></span>
			</g:link>
			
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

		<g:render template="/layouts/templates/footer"/>

		<div id="cookiesPopUp">
			<g:render template="/layouts/templates/popUpCookies" ></g:render>
		</div>

		<%-- Hacer la importacion de archivos --%>
		<g:javascript src="layoutMain.js"/>
		<g:javascript src="spinner.js"/>
		<g:javascript src="CookiesService.js"/>
		<%-- JS del template --%>
		<g:javascript src="template/breakpoints.min.js"/>
		<g:javascript src="template/browser.min.js"/>
		<g:javascript src="template/main.js"/>
		<g:javascript src="template/util.js"/>

	</body>
</html>
