
<%@ page import="Colecciones.Autor" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain"/>
		<g:set var="entityName" value="${message(code: 'autor.label', default: 'Autor')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-autor" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-autor" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list autor">
			
				<g:if test="${autorInstance?.apellido}">
				<li class="fieldcontain">
					<span id="apellido-label" class="property-label"><g:message code="autor.apellido.label" default="Apellido" /></span>
					
						<span class="property-value" aria-labelledby="apellido-label"><g:fieldValue bean="${autorInstance}" field="apellido"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${autorInstance?.difunto}">
				<li class="fieldcontain">
					<span id="difunto-label" class="property-label"><g:message code="autor.difunto.label" default="Difunto" /></span>
					
						<span class="property-value" aria-labelledby="difunto-label"><g:fieldValue bean="${autorInstance}" field="difunto"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${autorInstance?.edad}">
				<li class="fieldcontain">
					<span id="edad-label" class="property-label"><g:message code="autor.edad.label" default="Edad" /></span>
					
						<span class="property-value" aria-labelledby="edad-label"><g:fieldValue bean="${autorInstance}" field="edad"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${autorInstance?.fechaInscripcion}">
				<li class="fieldcontain">
					<span id="fechaInscripcion-label" class="property-label"><g:message code="autor.fechaInscripcion.label" default="Fecha Inscripcion" /></span>
					
						<span class="property-value" aria-labelledby="fechaInscripcion-label"><g:formatDate date="${autorInstance?.fechaInscripcion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${autorInstance?.nombre}">
				<li class="fieldcontain">
					<span id="nombre-label" class="property-label"><g:message code="autor.nombre.label" default="Nombre" /></span>
					
						<span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${autorInstance}" field="nombre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${autorInstance?.rutaImagen}">
				<li class="fieldcontain">
					<span id="rutaImagen-label" class="property-label"><g:message code="autor.rutaImagen.label" default="Ruta Imagen" /></span>
					
						<span class="property-value" aria-labelledby="rutaImagen-label"><g:fieldValue bean="${autorInstance}" field="rutaImagen"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${autorInstance?.ultimaModificacion}">
				<li class="fieldcontain">
					<span id="ultimaModificacion-label" class="property-label"><g:message code="autor.ultimaModificacion.label" default="Ultima Modificacion" /></span>
					
						<span class="property-value" aria-labelledby="ultimaModificacion-label"><g:formatDate date="${autorInstance?.ultimaModificacion}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:autorInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${autorInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
