<%@ page import="Colecciones.Autor" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain"/>
		<g:set var="entityName" value="${message(code: 'autor.label', default: 'Autor')}" />
		<title><g:message code="default.list.label" args="[entityName]"/></title>
	</head>
	<body>
		<a href="#list-autor" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-autor" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="apellido" title="${message(code: 'autor.apellido.label', default: 'Apellido')}" />
					
						<g:sortableColumn property="difunto" title="${message(code: 'autor.difunto.label', default: 'Difunto')}" />
					
						<g:sortableColumn property="edad" title="${message(code: 'autor.edad.label', default: 'Edad')}" />
					
						<g:sortableColumn property="fechaInscripcion" title="${message(code: 'autor.fechaInscripcion.label', default: 'Fecha Inscripcion')}" />
					
						<g:sortableColumn property="nombre" title="${message(code: 'autor.nombre.label', default: 'Nombre')}" />
					
						<g:sortableColumn property="rutaImagen" title="${message(code: 'autor.rutaImagen.label', default: 'Ruta Imagen')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${autorInstanceList}" status="i" var="autorInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${autorInstance.id}">${fieldValue(bean: autorInstance, field: "apellido")}</g:link></td>
					
						<td>${fieldValue(bean: autorInstance, field: "difunto")}</td>
					
						<td>${fieldValue(bean: autorInstance, field: "edad")}</td>
					
						<td><g:formatDate date="${autorInstance.fechaInscripcion}" /></td>
					
						<td>${fieldValue(bean: autorInstance, field: "nombre")}</td>
					
						<td>${fieldValue(bean: autorInstance, field: "rutaImagen")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${autorInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
