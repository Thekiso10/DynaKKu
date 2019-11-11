
<%@ page import="Colecciones.Mangas" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain">
		<g:set var="entityName" value="${message(code: 'mangas.label', default: 'Mangas')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-mangas" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-mangas" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list mangas">
			
				<g:if test="${mangasInstance?.nombreManga}">
				<li class="fieldcontain">
					<span id="nombreManga-label" class="property-label"><g:message code="mangas.nombreManga.label" default="Nombre Manga" /></span>
					
						<span class="property-value" aria-labelledby="nombreManga-label"><g:fieldValue bean="${mangasInstance}" field="nombreManga"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mangasInstance?.urlImg}">
				<li class="fieldcontain">
					<span id="urlImg-label" class="property-label"><g:message code="mangas.urlImg.label" default="Url Img" /></span>
					
						<span class="property-value" aria-labelledby="urlImg-label"><g:fieldValue bean="${mangasInstance}" field="urlImg"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mangasInstance?.completado}">
				<li class="fieldcontain">
					<span id="completado-label" class="property-label"><g:message code="mangas.completado.label" default="Completado" /></span>
					
						<span class="property-value" aria-labelledby="completado-label"><g:formatBoolean boolean="${mangasInstance?.completado}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${mangasInstance?.serieAcabada}">
				<li class="fieldcontain">
					<span id="serieAcabada-label" class="property-label"><g:message code="mangas.serieAcabada.label" default="Serie Acabada" /></span>
					
						<span class="property-value" aria-labelledby="serieAcabada-label"><g:formatBoolean boolean="${mangasInstance?.serieAcabada}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${mangasInstance?.serieConsecutiva}">
				<li class="fieldcontain">
					<span id="serieConsecutiva-label" class="property-label"><g:message code="mangas.serieConsecutiva.label" default="Serie Consecutiva" /></span>
					
						<span class="property-value" aria-labelledby="serieConsecutiva-label"><g:formatBoolean boolean="${mangasInstance?.serieConsecutiva}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${mangasInstance?.deseado}">
				<li class="fieldcontain">
					<span id="deseado-label" class="property-label"><g:message code="mangas.deseado.label" default="Deseado" /></span>
					
						<span class="property-value" aria-labelledby="deseado-label"><g:formatBoolean boolean="${mangasInstance?.deseado}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${mangasInstance?.numTomosActuales}">
				<li class="fieldcontain">
					<span id="numTomosActuales-label" class="property-label"><g:message code="mangas.numTomosActuales.label" default="Num Tomos Actuales" /></span>
					
						<span class="property-value" aria-labelledby="numTomosActuales-label"><g:fieldValue bean="${mangasInstance}" field="numTomosActuales"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mangasInstance?.numTomosMaximos}">
				<li class="fieldcontain">
					<span id="numTomosMaximos-label" class="property-label"><g:message code="mangas.numTomosMaximos.label" default="Num Tomos Maximos" /></span>
					
						<span class="property-value" aria-labelledby="numTomosMaximos-label"><g:fieldValue bean="${mangasInstance}" field="numTomosMaximos"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mangasInstance?.precioTotal}">
				<li class="fieldcontain">
					<span id="precioTotal-label" class="property-label"><g:message code="mangas.precioTotal.label" default="Precio Total" /></span>
					
						<span class="property-value" aria-labelledby="precioTotal-label"><g:fieldValue bean="${mangasInstance}" field="precioTotal"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${mangasInstance?.fechaInscripcion}">
				<li class="fieldcontain">
					<span id="fechaInscripcion-label" class="property-label"><g:message code="mangas.fechaInscripcion.label" default="Fecha Inscripcion" /></span>
					
						<span class="property-value" aria-labelledby="fechaInscripcion-label"><g:formatDate date="${mangasInstance?.fechaInscripcion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${mangasInstance?.ultimaModificacion}">
				<li class="fieldcontain">
					<span id="ultimaModificacion-label" class="property-label"><g:message code="mangas.ultimaModificacion.label" default="Ultima Modificacion" /></span>
					
						<span class="property-value" aria-labelledby="ultimaModificacion-label"><g:formatDate date="${mangasInstance?.ultimaModificacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${mangasInstance?.autor}">
				<li class="fieldcontain">
					<span id="autor-label" class="property-label"><g:message code="mangas.autor.label" default="Autor" /></span>
					
						<span class="property-value" aria-labelledby="autor-label"><g:link controller="autor" action="show" id="${mangasInstance?.autor?.id}">${mangasInstance?.autor?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${mangasInstance?.demografia}">
				<li class="fieldcontain">
					<span id="demografia-label" class="property-label"><g:message code="mangas.demografia.label" default="Demografia" /></span>
					
						<span class="property-value" aria-labelledby="demografia-label"><g:link controller="demografia" action="show" id="${mangasInstance?.demografia?.id}">${mangasInstance?.demografia?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${mangasInstance?.mangaSpinOff}">
				<li class="fieldcontain">
					<span id="mangaSpinOff-label" class="property-label"><g:message code="mangas.mangaSpinOff.label" default="Manga Spin Off" /></span>
					
						<span class="property-value" aria-labelledby="mangaSpinOff-label"><g:link controller="mangas" action="show" id="${mangasInstance?.mangaSpinOff?.id}">${mangasInstance?.mangaSpinOff?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:mangasInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${mangasInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
