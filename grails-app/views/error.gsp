<!DOCTYPE html>
<html>
	<head>
		<title>Error ha ocurido</title>
		<meta name="layout" content="layoutMain">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
	</head>
	<body>
		<g:if env="development">
			<g:renderException exception="${exception}" />
		</g:if>
		<g:else>
			<div id="notfound">
				<div class="notfound">
					<div class="notfound-404">
						<h1>
							<g:message code="errores.error500.oops"/>
						</h1>
						<h2>
							<g:message code="errores.error500.cuerpo"/>
						</h2>
					</div>
					<g:link controller="estadisticas" action="general" class="btn btnInicio">
						<g:message code="default.link.start.label"/>
					</g:link>
				</div>
			</div>
		</g:else>
	</body>
</html>
