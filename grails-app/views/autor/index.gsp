<%@ page import="Colecciones.Autor" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain"/>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'colecciones.css')}" type="text/css">
		<g:set var="entityName" value="${message(code: 'autor.label', default: 'Autor')}" />
		<title><g:message code="default.list.label" args="[entityName]"/></title>
	</head>
	<body>
		<div id="list-autor" class="col-sm-12" role="main">
			<div class="container padding-left-0">
				<div id="list-autor" class="content scaffold-list" role="main">
				
					<h1>
						<g:message code="default.list.label" args="[entityName]" />
					</h1>
					
					<g:if test="${flash.message}">
						<div class="message" role="status">${flash.message}</div>
					</g:if>
					
					<div id="tableAutorList" class="table-responsive">
						<table class="table table-dark table-striped table-hover">
							<thead class="thead-dark">
								<tr>
									
									<g:sortableColumn scope="col" property="nombre" title="${message(code: 'autor.nombre.label', default: 'Nombre')}" />
									
									<g:sortableColumn scope="col" property="apellido" title="${message(code: 'autor.apellido.label', default: 'Apellido')}" />
									
									<g:sortableColumn scope="col" property="edad" title="${message(code: 'autor.edad.label', default: 'Edad')}" />
									
									<g:sortableColumn scope="col" property="nacionalidad" title="${message(code: 'autor.nacionalidad.label', default: 'nacionalidad')}" />
									
									<g:sortableColumn scope="col" property="genero" title="${message(code: 'autor.genero.label', default: 'genero')}" />
								
									<g:sortableColumn scope="col" property="difunto" title="${message(code: 'autor.difunto.label', default: 'Difunto')}" />
								
									<g:sortableColumn scope="col" property="rutaImagen" title="${message(code: 'autor.imagen.label', default: 'Ruta Imagen')}" />
									
									<g:sortableColumn scope="col" property="fechaInscripcion" title="${message(code: 'autor.fechaInscripcion.label', default: 'Fecha Inscripcion')}" />
								
								</tr>
							</thead>
							<tbody>
							<g:each in="${autorInstanceList}" status="i" var="autorInstance">
								<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
									
									<td><g:link action="show" id="${autorInstance.id}">${fieldValue(bean: autorInstance, field: "nombre")}</g:link></td>
									
									<td><g:link action="show" id="${autorInstance.id}">${fieldValue(bean: autorInstance, field: "apellido")}</g:link></td>
									
									<td>${fieldValue(bean: autorInstance, field: "edad")}</td>
									
									<td>${fieldValue(bean: autorInstance, field: "nacionalidad")}</td>
									
									<td>${fieldValue(bean: autorInstance, field: "genero")}</td>
									
									<td>
										<g:if test="${!autorInstance.difunto}">
											<g:message code="autores.estado.vivo" default="Vivo"/>
										</g:if>
										<g:else>
											<g:message code="autores.estado.muerto" default="Muerto"/>
										</g:else>
									</td>
								
									<td>
										<g:if test="${!autorInstance.rutaImagen}">
											<g:message code="autor.rutaImagen.label.noFoto" default="No hay Foto"/>
										</g:if>
										<g:else>
											<g:message code="autor.rutaImagen.label.siFoto" default="Tiene Foto"/>
										</g:else>
									</td>
									
									<td><g:formatDate date="${autorInstance.fechaInscripcion}" /></td>
									
									<td><button>sdfdsf</button></td>
									
								</tr>
							</g:each>
							</tbody>
						</table>
					</div>
					
					<div class="pagination">
						<g:paginate total="${autorInstanceCount ?: 0}" />
					</div>
					
				</div>
			</div>
		</div>
	</body>
</html>
