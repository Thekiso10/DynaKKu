<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain"/>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'autores.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'datePicker/datepicker.css')}" type="text/css">
		<g:set var="entityName" value="${message(code: 'layoutMenu.botonesColeccion.autor', default: 'Autor')}" />
		<title><g:message code="default.create.label" args="[entityName]"/></title>
	</head>
	<body>
		<div id="create-autor" class="col-sm-12" role="main">
			<g:form url="[resource:autorInstance, action:'save']" enctype='multipart/form-data' id="formCreateAutor" class="form-principal">
				<div class="menu navbar-collapse" role="navigation">
					<div class="container">
						<ul class="navbar-nav">
							<li><g:submitButton name="createSecundaro" class="btn btnSave" value="${message(code: 'default.button.create.label', default: 'Create')}"/></li>
							<li><g:link class="btn btnLlist" action="index"><g:message code="autores.list.label" /></g:link></li>
						</ul>
						<ul class="navbar-nav navbar-right">
							<li><a href="#" class="btn btnSkip" tabindex="-1" onclick="history.back()"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a></li>
						</ul>
					</div>
				</div>

				<div class="container">

					<h2>
						<g:message code="default.create.label" args="[entityName]" />
					</h2>
					
					<g:if test="${flash.message}">
						<div class="flash mensajes iconoMensajes" role="status">${flash.message}</div>
					</g:if>
					
					<g:if test="${flash.error}">
						<div class="flash errors iconoError" role="status">${flash.error}</div>
					</g:if>
					
					<g:hasErrors bean="${autorInstance}">
						<ul class="errors" role="alert">
							<g:eachError bean="${autorInstance}" var="error">
							<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
							</g:eachError>
						</ul>
					</g:hasErrors>
				
					<fieldset class="form">
						<div class="panel-form row">
							<g:render template="templates/form"/>
						</div>
					</fieldset>
					<fieldset class="buttons">
						<div class="col-sm-12 divButtonSave">
							<g:submitButton name="create" class="save btn btnSave" value="${message(code: 'default.button.create.label', default: 'Create')}" />
						</div>
					</fieldset>
				</div>
			</g:form>
		</div>

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
