<%@ page import="Colecciones.Autor" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain"/>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'colecciones.css')}" type="text/css">
		<g:set var="entityName" value="${message(code: 'layoutMenu.botonesColeccion.autores', default: 'Autor')}" />
		<title><g:message code="default.list.label" args="[entityName]"/></title>
	</head>
	<body>
		<div id="list-autor" class="col-sm-12" role="main">
			<div class="container padding-left-0">
				<div class="content scaffold-list" role="main">
					
					<div class="menu navbar-collapse" role="navigation">
						<ul class="navbar-nav">
							<li><g:link class="btn btnLlist" action="create"><g:message code="autores.create.label" /></g:link></li>
						</ul>
						<ul class="navbar-nav">
							<li><g:link class="btn btnLlist" action="create"><g:message code="default.list.generatePDF.label" args="[entityName]"/></g:link></li>
						</ul>
						<ul class="navbar-nav">
							<li class="dropdown">
								<a href="#" class="btn btnExtra" onclick="modificarIconoMenu(this)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
									<span class="glyphicon glyphicon-chevron-down"></span><g:message code="autores.list.manage.label"/></a>
								<ul class="dropdown-menu styleDropdown">
									<li>
										<g:link class="btn btnMenu "><g:message code="autores.list.export.label"/></g:link>
									</li>
									<li>
										<g:link class="btn btnMenu"><g:message code="autores.list.import.label"/></g:link>
									</li>
								</ul>
							</li>
						</ul>
						<ul class="navbar-nav navbar-right">
							<li><a href="#" class="btn btnSkip" tabindex="-1" onclick="history.back()"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a></li>
						</ul>
					</div>
									
					<h1>
						<g:message code="default.list.label" args="[entityName]" />
					</h1>
					
					<g:if test="${flash.message}">
						<div class="message" role="status">${flash.message}</div>
					</g:if>
					
					<div id="tableAutorList" class="table-responsive">
						<table class="table table-dark table-striped table-hover">
							<thead class="thead-dark">
								<tr>
									
									<g:sortableColumn scope="col" property="nombre" title="${message(code: 'autor.nombre.label', default: 'Nombre')}" />
									
									<g:sortableColumn scope="col" property="apellido" title="${message(code: 'autor.apellido.label', default: 'Apellido')}" />
									
									<g:sortableColumn scope="col" property="edad" title="${message(code: 'autor.edad.label', default: 'Edad')}" />
									
									<g:sortableColumn scope="col" property="nacionalidad" title="${message(code: 'autor.nacionalidad.label', default: 'nacionalidad')}" />
									
									<g:sortableColumn scope="col" property="genero" title="${message(code: 'autor.genero.label', default: 'genero')}" />
								
									<g:sortableColumn scope="col" property="difunto" title="${message(code: 'autor.difunto.label', default: 'Difunto')}" />
								
									<g:sortableColumn scope="col" property="rutaImagen" title="${message(code: 'autor.imagen.label', default: 'Ruta Imagen')}" />
									
									<g:sortableColumn scope="col" property="fechaInscripcion" title="${message(code: 'autor.fechaInscripcion.label', default: 'Fecha Inscripcion')}" />
									<%-- Este Th es solo para estetica --%>
									<th></th>
								
								</tr>
							</thead>
							<tbody>
							<g:each in="${autorInstanceList}" status="i" var="autorInstance">
								<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
									
									<td><g:link action="show" id="${autorInstance.id}">${fieldValue(bean: autorInstance, field: "nombre")}</g:link></td>
									
									<td><g:link action="show" id="${autorInstance.id}">${fieldValue(bean: autorInstance, field: "apellido")}</g:link></td>
									
									<td>${fieldValue(bean: autorInstance, field: "edad")}</td>
									
									<td>${fieldValue(bean: autorInstance, field: "nacionalidad")}</td>
									
									<td>${fieldValue(bean: autorInstance, field: "genero")}</td>
									
									<td>
										<g:if test="${!autorInstance.difunto}">
											<g:message code="autores.estado.vivo" default="Vivo"/>
										</g:if>
										<g:else>
											<g:message code="autores.estado.muerto" default="Muerto"/>
										</g:else>
									</td>
								
									<td>
										<g:if test="${!autorInstance.rutaImagen}">
											<g:message code="autor.rutaImagen.label.noFoto" default="No hay Foto"/>
										</g:if>
										<g:else>
											<g:message code="autor.rutaImagen.label.siFoto" default="Tiene Foto"/>
										</g:else>
									</td>
									
									<td><g:formatDate date="${autorInstance.fechaInscripcion}" /></td>
									
									<td>
										<g:link class="btn btnMenu" action="show" id="${autorInstance.id}"><g:message code="default.list.show.label" args="[entityName]"/></g:link>
									</td>
									
								</tr>
							</g:each>
							</tbody>
						</table>
					</div>
					
					<div class="col-sm-12 paginacion menu">
						<div class="pagination row">
							<g:paginate total="${autorInstanceCount ?: 0}" />
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</body>
</html>
