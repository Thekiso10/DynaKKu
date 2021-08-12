
<%@ page import="Colecciones.Autor; Colecciones.Mangas" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain">
		<g:set var="entityName" value="${message(code: (mangasRegistrados ? 'layoutMenu.botonesColeccion.mangas' : 'layoutMenu.botonesColeccion.mangas.deseado'), default: 'Mangas')}" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mangas.css')}" type="text/css">
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

		<section id="list-manga" role="main">

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

			<g:if test="${flash.error}">
				<div class="flash errors iconoError" role="status">
					${flash.error}
				</div>
			</g:if>

		<%-- Filtro --%>
			<g:form action="index" name="filterMangas" class="form">

				<g:hiddenField name="registrado" value="${mangasRegistrados}"/>

				<div id="filtroMangas" class="row gtr-uniform">
					<div class="col-3 col-12-xsmall">
						<g:textField name="nombreManga" class="tamanoInput" value="${params?.nombreManga}"
									 placeholder="${message(code: 'default.filter.placeholder.label', args: [message(code: 'autor.nombre.label')])}" />
					</div>

					<g:if test="${mangasRegistrados}">
						<div class="col-3 col-12-xsmall">
							<g:field name="numTomos" class="tamanoInput" type="number" value="${params?.numTomos}"
									 placeholder="${message(code: 'default.filter.placeholder.label', args: [message(code: 'mangas.numTomosActuales.label')])}" />
						</div>
					</g:if>

					<div class="col-3 col-12-xsmall">
						<g:select name="autor" from="${Colecciones.Autor.list()}" value="${params.autor}" optionKey="id"
								  noSelection='[null:"${message(code: 'default.filter.placeholder.label', args: [message(code: 'layoutMenu.botonesColeccion.autor')])}"]'/>
					</div>


					<div class="button-filter col-3 col-12-xsmall text-right">
						<button class="button primary small" type="submit" name="search" value="search" >
							<span class="glyphicon glyphicon-search"></span>
							<g:message code="default.button.filter" default="Filter" />
						</button>

						<button class="button small" type="submit" name="showAll" value="showAll">
							<span class="glyphicon glyphicon-list"></span>
							<g:message code="default.button.show.all.label" default="Show All" />
						</button>
					</div>
				</div>
			</g:form>

			<%-- Tablas --%>
			<div class="table-wrapper ${!mangasInstanceCount? 'hidden':''}">
				<g:if test="${mangasRegistrados}">
					<g:render template="templatesLists/listaRegistrados"/>
				</g:if>
				<g:else>
					<g:render template="templatesLists/listaDeseados"/>
				</g:else>
			</div>

			<g:if test="${flash.warn}">
				<div class="flash warn iconoWarning media" role="status">
					${flash.warn}
				</div>
			</g:if>

			<div class="col-sm-12 text-center ${mangasInstanceCount <= 10 ? 'hidden':''}">
				<div class="pagination">
					<g:paginate total="${mangasInstanceCount ?: 0}" params="${params}" />
				</div>
			</div>

			<g:hiddenField name="registrado" value="${mangasInstanceCount}"/>

		</section>

	</body>
</html>
