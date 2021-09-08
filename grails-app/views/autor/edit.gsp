<%@ page import="Colecciones.Autor" %>
<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain"/>
		<g:set var="entityName" value="${message(code: 'layoutMenu.botonesColeccion.autor', default: 'Autor')}" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'autores.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'datePicker/datepicker.css')}" type="text/css">
		<title><g:message code="default.edit.label" args="${[message(code: 'layoutMenu.botonesColeccion.autor'), "${autorInstance?.nombre + ' ' + autorInstance?.apellido}"]}" /></title>
	</head>
	<body>
		<section>
			<g:form url="[action:'updateAutor']" enctype='multipart/form-data' id="formEditAutor">
				<header class="main">
					<h1>
						<g:if test="${autorInstance.genero == Colecciones.Autor.Generos.MASCULINO}">
							<g:message code="default.edit.label" args="${[message(code: 'layoutMenu.botonesColeccion.autor'), "${autorInstance?.nombre + ' ' + autorInstance?.apellido}"]}" />
						</g:if>
						<g:elseif test="${autorInstance.genero == Colecciones.Autor.Generos.FEMENINO}">
							<g:message code="default.edit.femenino.label" args="${[message(code: 'layoutMenu.botonesColeccion.autora'), "${autorInstance?.nombre + ' ' + autorInstance?.apellido}"]}" />
						</g:elseif>
					</h1>
				</header>

				<g:if test="${flash.message}">
					<div class="flash mensajes iconoMensajes" role="status">${flash.message}</div>
				</g:if>

				<g:if test="${flash.error}">
					<div class="flash errors iconoError" role="status">${flash.error}</div>
				</g:if>

				<ul class="errors" role="alert">
					<g:eachError bean="${autorInstance}" var="error">
						<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>

				<g:hiddenField name="version" value="${autorInstance?.version}" />
				<g:hiddenField name="id" value="${autorInstance?.id}" />

				<fieldset class="form">
					<div class="row gtr-uniform">
						<g:render template="templates/form"/>
					</div>
				</fieldset>

				<fieldset class="buttonForms">
					<div>
						<g:submitButton name="update" class="button fit" value="${message(code: 'default.button.update.label', args: [message(code: 'layoutMenu.botonesColeccion.autor')])}" />
					</div>
				</fieldset>
			</g:form>
		</section>

		<g:javascript src="datePicker/datepickerInterval-yy.js" />

		<g:if test="${RequestContextUtils.getLocale(request) == new Locale('es')}">
			<g:javascript src="datePicker/locales/bootstrap-datepicker.es.js" />
		</g:if>
		<g:elseif test="${RequestContextUtils.getLocale(request) == new Locale('ca','es')}">
			<g:javascript src="datePicker/locales/bootstrap-datepicker.cat.js" />
		</g:elseif>
		<g:else>
			<g:javascript src="datePicker/locales/bootstrap-datepicker.js" />
		</g:else>

	</body>
</html>
