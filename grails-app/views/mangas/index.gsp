
<%@ page import="Colecciones.Autor; Colecciones.Mangas" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain">
		<g:set var="entityName" value="${message(code: 'layoutMenu.botonesColeccion.mangas', default: 'Mangas')}" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'colecciones.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mangas.css')}" type="text/css">
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="list-mangas" class="tablaGenericoa col-sm-12" role="main">

			<div class="menu navbar-collapse" role="navigation">
				<div class="container">

					<ul class="navbar-nav">
						<li><g:link class="btn btnLlist" action="create">
							<g:message code="layoutMenu.botonesColeccion.mangas.crear" />
						</g:link></li>
					</ul>

					<g:if test="${valorExportaListaConf}">
						<ul class="navbar-nav">
							<li class="dropdown">
								<a href="#" class="btn btnExtra" onclick="modificarIconoMenu(this)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
									<span class="glyphicon glyphicon-chevron-down"></span>
									<g:message code="autores.list.manage.label" />
								</a>

								<ul class="dropdown-menu styleDropdown">
									<li>
										<g:if test="${mangasInstanceList?.size > 0}">
											<g:link controller="transferenciaListado" action="ExportMangas" params="[registrado: mangasRegistrados]" class="btn btnMenu">
												<g:message code="modulos.exportacionListado.export.label" args="${message(code: 'layoutMenu.botonesColeccion.mangas')}"/>
											</g:link>
										</g:if>
										<g:else>
											<g:link class="btn btnMenu" disabled="disabled">
												<g:message code="modulos.exportacionListado.export.label" args="${message(code: 'layoutMenu.botonesColeccion.mangas')}"/>
											</g:link>
										</g:else>
									</li>
									<li>
										<button class="btn btnMenu" data-toggle="modal" data-target="#ImportMangasModal">
											<g:message code="modulos.exportacionListado.import.label" args="${message(code: 'layoutMenu.botonesColeccion.mangas')}"/>
										</button>
									</li>
								</ul>

							</li>
						</ul>
					</g:if>

					<ul class="navbar-nav navbar-right">
						<li>
							<a href="#" class="btn btnSkip" tabindex="-1" onclick="history.back()">
								<g:message code="default.link.skip.label" default="Skip to content&hellip;" />
							</a>
						</li>
					</ul>
				</div>
			</div>

			<div class="container">
				<div class="content scaffold-list" role="main">

					<h2>
						<g:message code="default.list.label" args="[entityName]" />
					</h2>

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
					<g:form action="index" name="filterMangas" class="form-inline">
						<div id="filtroMangas" class="col-sm-12">
							<h3 class="text-center titleFilter">
								<g:message code="default.filter.label" args="[entityName]" />
							</h3>
							<div class="bodyFilter">

								<div class="form-group">
									<label for="nombreManga" class="labelFilter">
										<g:message code="mangas.nombreManga.label" default="Nombre" />
									</label>
									<g:textField name="nombreManga" class="tamanoInput" value="${params?.nombreManga}" placeholder="${message(code: 'default.filter.placeholder.label', args: [message(code: 'autor.nombre.label')])}" />
								</div>

								<div class="form-group">
									<label for="autor" class="labelFilter">
										<g:message code="layoutMenu.botonesColeccion.autor" default="apellido" />:
									</label>
									<g:select name="autor" from="${Colecciones.Autor.list()}" value="${params.autor}" optionKey="id" noSelection="[null:'']"/>
								</div>

								<g:if test="${mangasRegistrados}">
									<div class="form-group">
										<label for="numTomos" class="labelFilter">
											<g:message code="mangas.numTomosActuales.label" default="edad" />:
										</label>
										<g:field name="numTomos" class="tamanoInput" type="number" value="${params?.numTomos}" placeholder="${message(code: 'default.filter.placeholder.label', args: [message(code: 'mangas.numTomosActuales.label')])}" />
									</div>
								</g:if>

								<g:hiddenField name="registrado" value="${mangasRegistrados}"/>

								<div>
									<button type="submit" class="btn btn-filter" name="search" value="search" >
										<span class="glyphicon glyphicon-search"></span>
										<g:message code="default.button.filter" default="Filter" />
									</button>

									<button type="submit" class="btn btn-reset commit" name="showAll" value="showAll">
										<span class="glyphicon glyphicon-list"></span>
										<g:message code="default.button.show.all.label" default="Show All" />
									</button>
								</div>

							</div>
						</div>
					</g:form>

					<%-- Tablas --%>
					<div id="tableMangasList" class="tableDynamic table-responsive ${!mangasInstanceCount? 'hidden':''}">
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

                    <div class="col-sm-12 paginacion menu ${mangasInstanceCount <= 10 ? 'hidden':''}">
                        <div class="pagination row">
                            <g:paginate total="${mangasInstanceCount ?: 0}" params="${params}" />
                        </div>
                    </div>
					<g:hiddenField name="registrado" value="${mangasInstanceCount}"/>
				</div>
			</div>

			<div id="ImportMangasModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="ImportMangasModal" aria-hidden="true">
				<g:render  template="templates/modalImportMangas"/>
			</div>

		</div>
	</body>
</html>
