<%@ page import="Colecciones.Autor"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="layoutMain" />
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'colecciones.css')}" type="text/css">
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'autores.css')}" type="text/css">
<g:set var="entityName"
	value="${message(code: 'layoutMenu.botonesColeccion.autores', default: 'Autor')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<div id="list-autor" class="col-sm-12" role="main">
		<div class="container padding-left-0">
			<div class="content scaffold-list" role="main">

				<div class="menu navbar-collapse" role="navigation">
					<ul class="navbar-nav">
						<li><g:link class="btn btnLlist" action="create">
								<g:message code="autores.create.label" />
							</g:link></li>
					</ul>
					<ul class="navbar-nav">
						<li><g:link class="btn btnLlist" action="create">
								<g:message code="default.list.generatePDF.label"
									args="[entityName]" />
							</g:link></li>
					</ul>
					<ul class="navbar-nav">
						<li class="dropdown"><a href="#" class="btn btnExtra"
							onclick="modificarIconoMenu(this)" data-toggle="dropdown"
							role="button" aria-haspopup="true" aria-expanded="false"> <span
								class="glyphicon glyphicon-chevron-down"></span>
							<g:message code="autores.list.manage.label" /></a>
							<ul class="dropdown-menu styleDropdown">
								<li><g:link class="btn btnMenu ">
										<g:message code="autores.list.export.label" />
									</g:link></li>
								<li><g:link class="btn btnMenu">
										<g:message code="autores.list.import.label" />
									</g:link></li>
							</ul></li>
					</ul>
					<ul class="navbar-nav navbar-right">
						<li><a href="#" class="btn btnSkip" tabindex="-1"
							onclick="history.back()"><g:message
									code="default.link.skip.label"
									default="Skip to content&hellip;" /></a></li>
					</ul>
				</div>

				<h1>
					<g:message code="default.list.label" args="[entityName]" />
				</h1>

				<g:if test="${flash.message}">
					<div class="flash mensajes iconoMensajes" role="status">
						${flash.message}
					</div>
				</g:if>

				<%-- Filtro --%>
				<g:form action="index" name="filterAutor" class="form-inline">
					<div id="filtroAutor" class="col-sm-12">
						<h3 class="text-center titleFilter">
							<g:message code="default.filter.label" args="[entityName]" />
						</h3>
						<div class="row bodyFilter">
							<div class="form-group">
								<label for="nombre" class="labelFilter"> <g:message
										code="autor.nombre.label" default="Nombre" />:
								</label>
								<g:textField name="nombre" class="tamanoInput"
									value="${params?.nombre}"
									placeholder="${message(code: 'default.filter.placeholder.label', args: [message(code: 'autor.nombre.label')])}" />
							</div>
							<div class="form-group">
								<label for="apellido" class="labelFilter"> <g:message
										code="autor.apellido.label" default="apellido" />:
								</label>
								<g:textField class="tamanoInput" name="apellido"
									value="${params?.apellido}"
									placeholder="${message(code: 'default.filter.placeholder.label', args: [message(code: 'autor.apellido.label')])}" />
							</div>
							<div class="form-group">
								<label for="edad" class="labelFilter"> <g:message
										code="autor.edad.label" default="edad" />:
								</label>
								<g:field name="edad" class="tamanoInput" type="number"
									value="${params?.edad}"
									placeholder="${message(code: 'default.filter.placeholder.label', args: [message(code: 'autor.edad.label')])}" />
							</div>

							<button type="submit" class="btn btn-filter" name="search"
								value="search">
								<span class="glyphicon glyphicon-search"></span>
								<g:message code="receiver.filter.label" default="Filter" />
							</button>

							<button type="submit" class="btn btn-reset commit" name="showAll"
								value="showAll">
								<span class="glyphicon glyphicon-list"></span>
								<g:message code="default.button.show.all.label"
									default="Show All" />
							</button>

						</div>
					</div>
				</g:form>

				<div id="tableAutorList"
					class="table-responsive ${!autorInstanceList? 'borderTransparent':''}">
					<table
						class="table table-dark table-striped table-hover ${!autorInstanceList? 'hidden':''}">
						<thead class="thead-dark">
							<tr>

								<g:sortableColumn scope="col" property="nombre"
									title="${message(code: 'autor.nombre.label', default: 'Nombre')}" />

								<g:sortableColumn scope="col" property="apellido"
									title="${message(code: 'autor.apellido.label', default: 'Apellido')}" />

								<g:sortableColumn scope="col" property="edad"
									title="${message(code: 'autor.edad.label', default: 'Edad')}" />

								<g:sortableColumn scope="col" property="nacionalidad"
									title="${message(code: 'autor.nacionalidad.label', default: 'nacionalidad')}" />

								<g:sortableColumn scope="col" property="genero"
									title="${message(code: 'autor.genero.label', default: 'genero')}" />

								<g:sortableColumn scope="col" property="difunto"
									title="${message(code: 'autor.difunto.label', default: 'Difunto')}" />

								<g:sortableColumn scope="col" property="rutaImagen"
									title="${message(code: 'autor.imagen.label', default: 'Ruta Imagen')}" />

								<g:sortableColumn scope="col" property="fechaInscripcion"
									title="${message(code: 'autor.fechaInscripcion.label', default: 'Fecha Inscripcion')}" />
								<%-- Este Th es solo para estetica --%>
								<th></th>

							</tr>
						</thead>
						<tbody>
							<g:each in="${autorInstanceList}" status="i" var="autorInstance">
								<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

									<td><g:link action="show" id="${autorInstance.id}">
											${fieldValue(bean: autorInstance, field: "nombre")}
										</g:link></td>

									<td><g:link action="show" id="${autorInstance.id}">
											${fieldValue(bean: autorInstance, field: "apellido")}
										</g:link></td>

									<td>
										${fieldValue(bean: autorInstance, field: "edad")}
									</td>

									<td>
										${autorInstance.nacionalidad.toString().toUpperCase()}
									</td>

									<td>
										${fieldValue(bean: autorInstance, field: "genero")}
									</td>

									<td><g:if test="${!autorInstance.difunto}">
											<g:message code="autores.estado.vivo" default="Vivo" />
										</g:if> <g:else>
											<g:message code="autores.estado.muerto" default="Muerto" />
										</g:else></td>

									<td><g:if test="${!autorInstance.rutaImagen}">
											<g:message code="autor.rutaImagen.label.noFoto"
												default="No hay Foto" />
										</g:if> <g:else>
											<g:message code="autor.rutaImagen.label.siFoto"
												default="Tiene Foto" />
										</g:else></td>

									<td><g:formatDate date="${autorInstance.fechaInscripcion}" /></td>

									<td><g:link class="btn btnMenu" action="show"
											id="${autorInstance.id}">
											<g:message code="default.list.show.label" args="[entityName]" />
										</g:link></td>

								</tr>
							</g:each>
						</tbody>
					</table>
				</div>

				<g:if test="${flash.warn}">
					<div class="flash warn iconoWarning" role="status">
						${flash.warn}
					</div>
				</g:if>

				<div
					class="col-sm-12 paginacion menu ${autorInstanceCount <= 10 ? 'hidden':''}">
					<div class="pagination row">
						<g:paginate total="${autorInstanceCount ?: 0}" params="${params}" />
					</div>
				</div>

			</div>
		</div>
	</div>
</body>
</html>
