<%@ page import="Colecciones.Autor"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="layoutMain" />
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'autores.css')}" type="text/css">
	<g:set var="entityName" value="${message(code: 'layoutMenu.botonesColeccion.autores', default: 'Autor')}" />
	<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<section id="list-autor" role="main">

		<header class="main">
			<h1>
				<g:message code="default.list.label" args="[entityName]" />
			</h1>
		</header>

	</section>
</body>
</html>
