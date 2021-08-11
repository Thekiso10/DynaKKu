<%@ page import="Colecciones.Mangas" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain">
		<g:set var="entityName" value="${message(code: 'layoutMenu.botonesColeccion.manga', default: 'Mangas')}" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mangas.css')}" type="text/css">
		<title><g:message code="default.edit.label" args="${[entityName, "${mangasInstance.nombreManga}"]}" /></title>
	</head>
	<body>

		<section>
			<g:form url="[resource:mangasInstance, action:'update']" enctype='multipart/form-data' id="formEditMangas" >
				<header class="main">
					<h2>
						<g:message code="default.edit.label" args="${[entityName, "${mangasInstance.nombreManga}"]}"/>
					</h2>
				</header>

				<g:if test="${flash.message}">
					<div class="flash mensajes iconoMensajes" role="status">${flash.message}</div>
				</g:if>

				<g:if test="${flash.error}">
					<div class="flash errors iconoError" role="status">${flash.error}</div>
				</g:if>

				<g:hasErrors bean="${mangasInstance}">
					<ul class="errors" role="alert">
						<g:eachError bean="${mangasInstance}" var="error">
							<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
						</g:eachError>
					</ul>
				</g:hasErrors>

				<g:hiddenField name="version" value="${mangasInstance?.version}" />
				<g:hiddenField name="id" value="${mangasInstance?.id}" />

				<fieldset class="form">
					<div class="row gtr-uniform">
						<g:render template="templates/form"/>
					</div>
				</fieldset>

				<fieldset class="buttonForms">
					<div>
						<g:submitButton name="update" class="button fit" value="${message(code: 'default.button.update.label', args: [message(code: 'default.button.create.label')])}" />
					</div>
				</fieldset>
			</g:form>
		</section>

	<g:javascript src="Mangas.js"/>

	</body>
</html>
