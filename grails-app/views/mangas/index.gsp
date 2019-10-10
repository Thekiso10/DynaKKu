
<%@ page import="Colecciones.Mangas" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'mangas.label', default: 'Mangas')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-mangas" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-mangas" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="nombreManga" title="${message(code: 'mangas.nombreManga.label', default: 'Nombre Manga')}" />
					
						<g:sortableColumn property="urlImg" title="${message(code: 'mangas.urlImg.label', default: 'Url Img')}" />
					
						<g:sortableColumn property="completado" title="${message(code: 'mangas.completado.label', default: 'Completado')}" />
					
						<g:sortableColumn property="serieAcabada" title="${message(code: 'mangas.serieAcabada.label', default: 'Serie Acabada')}" />
					
						<g:sortableColumn property="serieConsecutiva" title="${message(code: 'mangas.serieConsecutiva.label', default: 'Serie Consecutiva')}" />
					
						<g:sortableColumn property="deseado" title="${message(code: 'mangas.deseado.label', default: 'Deseado')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${mangasInstanceList}" status="i" var="mangasInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${mangasInstance.id}">${fieldValue(bean: mangasInstance, field: "nombreManga")}</g:link></td>
					
						<td>${fieldValue(bean: mangasInstance, field: "urlImg")}</td>
					
						<td><g:formatBoolean boolean="${mangasInstance.completado}" /></td>
					
						<td><g:formatBoolean boolean="${mangasInstance.serieAcabada}" /></td>
					
						<td><g:formatBoolean boolean="${mangasInstance.serieConsecutiva}" /></td>
					
						<td><g:formatBoolean boolean="${mangasInstance.deseado}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${mangasInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
