
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
					<div id="imgAutor" class="col-sm-3">
						<g:if test="${autorInstance?.rutaImagen}">
							<img class="img-responsive" src="${createLink(controller:'Autor', action:'autor_image', id:autorInstance.id)}" alt="${autorInstance?.nombre}"/>
						</g:if>
						<g:else>
							<g:img class="img-responsive" dir="images/imgWeb" file="userNoFoto.png"/>
						</g:else>
					</div>
					<div id="infoAutor" class="col-sm-9">
						<div class="col-sm-6">
							<g:if test="${autorInstance?.nombre}">
								<div class="row">
									<h4 id="nombre-label" class="property-label col-sm-4"><g:message code="autor.nombre.label" default="nombre" />:</h4>
									<span class="property-value col-sm-8" aria-labelledby="nombre-label"><g:fieldValue bean="${autorInstance}" field="nombre"/></span>
								</div>
							</g:if>
							
							<g:if test="${autorInstance?.apellido}">
								<div class="row">
									<h4 id="apellido-label" class="property-label col-sm-4"><g:message code="autor.apellido.label" default="Apellido" />:</h4>
									<span class="property-value col-sm-8" aria-labelledby="apellido-label"><g:fieldValue bean="${autorInstance}" field="apellido"/></span>
								</div>
							</g:if>
							
							<div class="row">
								<h4 id="difunto-label" class="property-label col-sm-4"><g:message code="autor.difunto.label" default="Difunto" />:</h4>
								<g:if test="${!autorInstance?.difunto}">
									<span class="property-value col-sm-8" aria-labelledby="difunto-label"><g:message code="autores.estado.vivo" default="Vivo" /></span>
								</g:if>
								<g:else>
									<span class="property-value col-sm-8" aria-labelledby="difunto-label"><g:message code="autores.estado.muerto" default="Muerto" /></span>
								</g:else>
							</div>
						</div>
						
						<div class="col-sm-6">
							<g:if test="${autorInstance?.edad}">
								<div class="row">
									<h4 id="edad-label" class="property-label col-sm-3"><g:message code="autor.edad.label" default="edad" />:</h4>
									<span class="property-value col-sm-9" aria-labelledby="edad-label">
										<g:fieldValue bean="${autorInstance}" field="edad"/>
										<g:message code="autor.edad.anyos.label" default="anyos" />
									</span>
								</div>
							</g:if>
							
							<g:if test="${autorInstance?.genero}">
								<div class="row">
									<h4 id="fechaInscripcion-label" class="property-label col-sm-4"><g:message code="autor.genero.label" default="genero" />:</h4>
									<span class="property-value col-sm-8" aria-labelledby="genero-label">
										<g:fieldValue bean="${autorInstance}" field="genero"/>
									</span>
								</div>
							</g:if>
							
							<g:if test="${autorInstance?.nacionalidad}">
								<div class="row">
									<h4 id="nacionalidad-label" class="property-label col-sm-5"><g:message code="autor.nacionalidad.label" default="nacionalidad" />:</h4>
									<span class="nacionalidad-value col-sm-7" aria-labelledby="nacionalidad-label"><g:country code="${autorInstance.nacionalidad}"/></span>
								</div>
							</g:if>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</body>
</html>
