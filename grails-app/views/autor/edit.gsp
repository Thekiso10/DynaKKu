<%@ page import="Colecciones.Autor" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain"/>
		<g:set var="entityName" value="${message(code: 'autor.label', default: 'Autor')}" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'colecciones.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'autores.css')}" type="text/css">
		<title><g:message code="default.edit.label" args="${[message(code: 'layoutMenu.botonesColeccion.autor'), "${autorInstance?.nombre + ' ' + autorInstance?.apellido}"]}" /></title>
	</head>
	<body>
		<div id="edit-autor" class="col-sm-12" role="main">
			<div class="container" id="formEditAutor" >
				<g:uploadForm action="updateAutor" controller="Autor">
					<div class="menu navbar-collapse" role="navigation">
						<ul class="navbar-nav">
							<li><g:submitButton name="update" class="save btn btnSave" value="${message(code: 'default.button.update.label', args: [message(code: 'layoutMenu.botonesColeccion.autor')])}" /></li>
							<li><g:link class="btn btnLlist" action="index"><g:message code="autores.list.label" /></g:link></li>
						</ul>
						<ul class="navbar-nav navbar-right">
							<li><a href="#" class="btn btnSkip" tabindex="-1" onclick="history.back()"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a></li>
						</ul>
					</div>
					
					<h1>
						<g:message code="default.edit.label" args="${[message(code: 'layoutMenu.botonesColeccion.autor'), "${autorInstance?.nombre + ' ' + autorInstance?.apellido}"]}" />
					</h1>
					
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
						<div class="panel-form row">
							<g:render template="form"/>
						</div>
					</fieldset>
					
					<fieldset class="buttons">
						<g:submitButton name="update" class="save btn btnSave" value="${message(code: 'default.button.update.label', args: [message(code: 'layoutMenu.botonesColeccion.autor')])}" />
					</fieldset>
				</g:uploadForm>
			</div>	
		</div>
	</body>
</html>
