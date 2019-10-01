<!DOCTYPE html>
<html>
	<head>
		<title>Error 404</title>
		<meta name="layout" content="layoutMain">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
	</head>
	<body>
		<div id="Error-404" class="col-sm-12" role="main">
			<div class="container">
				<h2><g:message code="errores.error404.titulo"/></h2>
				<h3><g:message code="errores.error404.referencia"/></h3>
				<p class="bodyError"><g:message code="errores.error404.cuerpo"/></p>

				<div class="col-sm-12 areaBotones">
					<div class="row">

						<div class="col-sm-6">
							<g:link controller="estadisticas" action="general" class="btn btnInicio">
								<g:message code="default.link.start.label"/>
							</g:link>
						</div>

						<div class="col-sm-6">
							<a href="#" class="btn btnBack" tabindex="-1" onclick="history.back()">
								<g:message code="default.link.skip.label" default="Skip to content&hellip;"/>
							</a>
						</div>

					</div>
				</div>

			</div>
		</div>	
	</body>
</html>