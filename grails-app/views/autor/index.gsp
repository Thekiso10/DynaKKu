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

		<g:if test="${flash.message}">
			<div class="flash mensajes iconoMensajes" role="status">
				${flash.message}
			</div>
		</g:if>

		<%-- Filtro --%>
		<h3 class="text-center">
			<g:message code="default.filter.label" args="[entityName]" />
		</h3>
		<g:form action="index" name="filterAutor" class="box">
			<div id="filtroAutor" class="row gtr-uniform">
				<div class="col-3 col-12-xsmall">
					<label for="nombre" class="labelFilter">
						<g:message code="autor.nombre.label" default="Nombre" />:
					</label>
					<g:textField name="nombre" class="tamanoInput"
								 value="${params?.nombre}"
								 placeholder="${message(code: 'default.filter.placeholder.label', args: [message(code: 'autor.nombre.label')])}" />
				</div>
				<div class="col-3 col-12-xsmall">
					<g:textField class="tamanoInput" name="apellido"
								 value="${params?.apellido}"
								 placeholder="${message(code: 'default.filter.placeholder.label', args: [message(code: 'autor.apellido.label')])}" />
				</div>

				<div class="col-3 col-12-xsmall">
					<button type="submit" class="button primary small" name="search" value="search">
						<span class="glyphicon glyphicon-search"></span>
						<g:message code="default.button.filter" default="Filter" />
					</button>

					<button type="submit" class="button small" name="showAll" value="showAll">
						<span class="glyphicon glyphicon-list"></span>
						<g:message code="default.button.show.all.label" default="Show All" />
					</button>
				</div>

			</div>
		</g:form>

	</section>
</body>
</html>
