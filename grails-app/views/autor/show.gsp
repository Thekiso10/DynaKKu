
<%@ page import="Colecciones.Autor" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
	<head>
		<meta name="layout" content="layoutMain"/>
		<g:set var="entityName" value="${message(code: 'layoutMenu.botonesColeccion.autor', default: 'Autor')}" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'autores.css')}" type="text/css">
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>

		<section id="autor-show">
			<g:form url="[resource:autorInstance, action:'delete']" method="DELETE">
				<nav class="navbar navbar-default">
					<div class="container-fluid">

						<div class="navbar-header">
							<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-autore-show" aria-expanded="false">
								<span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</button>
						</div>
						<!-- Collect the nav links, forms, and other content for toggling -->
						<div class="collapse navbar-collapse" id="navbar-autore-show">
							<ul class="nav navbar-nav">
								<li>
									<div>
										<g:link class="button" action="edit" resource="${autorInstance}"><g:message code="autores.edit.label" /></g:link>
									</div>
								</li>
							</ul>
							<ul class="nav navbar-nav navbar-right">
								<li>
									<g:actionSubmit class="button btn-danger" action="delete" value="${message(code: 'autores.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');" />
								</li>
								<li>
									<a href="#" class="button primary" tabindex="-1" onclick="history.back()"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
								</li>
							</ul>
						</div>
					</div>
				</nav>
			</g:form>

			<g:if test="${flash.message}">
				<div class="flash mensajes iconoMensajes" role="status">${flash.message}</div>
			</g:if>

			<g:if test="${flash.error}">
				<div class="flash errors iconoError" role="status">${flash.error}</div>
			</g:if>

			<header class="main">
				<h1>
					<g:message code="default.show.label" args="${[message(code: 'layoutMenu.botonesColeccion.autor')]}" /> -
					${autorInstance?.nombre} ${autorInstance?.apellido}
				</h1>
			</header>

			<div class="features">

				<article>
					<span id="imgAutor" class="image icon">
						<g:if test="${autorInstance?.imageAutor}">
							<img src="${createLink(controller:'Autor', action:'autor_image', id:autorInstance.id)}" alt="${autorInstance?.nombre}"/>
						</g:if>
						<g:else>
							<g:img dir="images/imgWeb" file="userNoFoto.png"/>
						</g:else>
					</span>
					<div class="content">
						<p id="nombre-label" >
							<g:message code="autor.nombre.label" default="nombre" />:
							<span>${autorInstance?.nombre}</span>
						</p>

						<p id="apellido-label">
							<g:message code="autor.apellido.label" default="Apellido" />:
							<span>${autorInstance?.apellido}</span>
						</p>

						<p id="edad-label">
							<g:message code="autor.nacimento.label" default="edad" />:
							<span aria-labelledby="edad-label">
								<g:formatDate format="dd/MM/yyyy" date="${autorInstance.fechaNacimento}"/>
								(${autorInstance.getEdadAutor()} <g:message code="autor.edad.anos.label" default="anyos" />)
							</span>
						</p>

					</div>
				</article>

				<article>
					<div class="content">
						<p id="difunto-label">
							<g:message code="autor.difunto.label" default="Difunto" />:
							<span aria-labelledby="difunto-label">
								<g:message code="${!autorInstance?.difunto ? "autores.estado.vivo" : "autores.estado.muerto"}" default="sin especificar" />
							</span
						</p>

						<p id="genero-label">
							<g:message code="autor.genero.label" default="genero" />:
							<span aria-labelledby="genero-label">
								<g:message code="autores.estado.${autorInstance?.genero}" default="sin especificar" />
								%{--<g:message code="${autorInstance?.genero == "Masculino" ? "autores.estado.MASCULINO" : "autores.estado.FEMENINO"}" default="sin especificar" />--}%
							</span
						</p>

						<p id="nacionalidad-label">
							<g:message code="autor.nacionalidad.label" default="nacionalidad" />:
							<span aria-labelledby="nacionalidad-label">
								<g:country code="${autorInstance.nacionalidad}"/>
							</span>
						</p>

					</div>
				</article>
			</div>

		</section>

	</body>
</html>
