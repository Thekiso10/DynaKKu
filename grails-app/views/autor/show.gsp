
<%@ page import="Colecciones.Autor" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain"/>
		<g:set var="entityName" value="${message(code: 'layoutMenu.botonesColeccion.autor', default: 'Autor')}" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'autores.css')}" type="text/css">
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>

		<section>
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
		</section>

	</body>
</html>
