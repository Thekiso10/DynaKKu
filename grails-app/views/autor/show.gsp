
<%@ page import="Colecciones.Autor" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain"/>
		<g:set var="entityName" value="${message(code: 'autor.label', default: 'Autor')}" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'colecciones.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'autores.css')}" type="text/css">
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="ver-autor" class="col-sm-12" role="main">
			<div class="container">
				
				<g:form url="[resource:autorInstance, action:'delete']" method="DELETE">
					<div class="menu navbar-collapse" role="navigation">
						<ul class="navbar-nav">
							<li><g:link class="btn btnSave" action="edit" resource="${autorInstance}"><g:message code="autores.edit.label" /></g:link></li>
							<li><g:link class="btn btnLlist" action="index"><g:message code="autores.list.label" /></g:link></li>
						</ul>
						<ul class="navbar-nav navbar-right">
							<li><g:actionSubmit class="btn btnDelete" action="delete" value="${message(code: 'autores.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');" /></li>
							<li><a href="#" class="btn btnSkip" tabindex="-1" onclick="history.back()"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a></li>
						</ul>
					</div>
				</g:form>
				
				<g:if test="${flash.message}">
					<div class="flash mensajes iconoMensajes" role="status">${flash.message}</div>
				</g:if>
				
				<g:if test="${flash.error}">
					<div class="flash errors iconoError" role="status">${flash.error}</div>
				</g:if>
				
				<h2>
					<g:message code="default.show.label" args="${[message(code: 'layoutMenu.botonesColeccion.autor')]}" />
				</h2>
				
				<div id="panel-ver-autor" class="panel-show-autor row">
					<h3>${autorInstance?.nombre} ${autorInstance?.apellido}</h3>
					<div id="imgAutor">
					
					</div>
					<div id="infoAutor">
					
					</div>
				</div>
				
			</div>
		</div>
	</body>
</html>
