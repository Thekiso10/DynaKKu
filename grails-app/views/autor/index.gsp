<%@ page import="Colecciones.Autor"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'autores.css')}" type="text/css">
		<g:set var="entityName" value="${message(code: 'layoutMenu.botonesColeccion.autores', default: 'Autor')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<section id="list-autor" role="main">

			<header class="main">
				<h1>
					<g:message code="default.list.label" args="[entityName]" />
				</h1>
			</header>

			<g:if test="${flash.message}">
				<div class="flash mensajes iconoMensajes" role="status">
					${flash.message}
				</div>
			</g:if>

			<%-- Filtro --%>
			<g:form action="index" name="filterAutor" class="form">
				<div id="filtroAutor" class="row gtr-uniform">
					<div class="col-3 col-12-xsmall">
						<g:textField name="nombre" value="${params?.nombre}"
									 placeholder="${message(code: 'default.filter.placeholder.label', args: [message(code: 'autor.nombre.label')])}" />
					</div>
					<div class="col-3 col-12-xsmall">
						<g:textField name="apellido" value="${params?.apellido}"
									 placeholder="${message(code: 'default.filter.placeholder.label', args: [message(code: 'autor.apellido.label')])}" />
					</div>

					<div class="button-filter col-6 col-12-xsmall text-right">
						<button type="submit" class="button primary small" name="search" value="search">
							<span class="glyphicon glyphicon-search"></span>
							<g:message code="default.button.filter" default="Filter" />
						</button>

						<button type="submit" class="button small" name="showAll" value="showAll">
							<span class="glyphicon glyphicon-list"></span>
							<g:message code="default.button.show.all.label" default="Show All" />
						</button>
					</div>
				</div>
			</g:form>

			<%-- Lista de Usuarios --%>
			<div class="table-wrapper ${!autorInstanceList? 'hide':''}">
				<table>
					<thead>
						<tr>
							<g:sortableColumn scope="col" property="nombre"
											  title="${message(code: 'autor.nombre.label', default: 'Nombre')}" />

							<g:sortableColumn scope="col" property="apellido"
											  title="${message(code: 'autor.apellido.label', default: 'Apellido')}" />

							<g:sortableColumn scope="col" property="fechaNacimiento"
											  title="${message(code: 'autor.fechaNacimento.label', default: 'Edad')}" />

							<g:sortableColumn scope="col" property="nacionalidad"
											  title="${message(code: 'autor.nacionalidad.label', default: 'nacionalidad')}" />

							<g:sortableColumn scope="col" property="genero"
											  title="${message(code: 'autor.genero.label', default: 'genero')}" />

							<g:sortableColumn scope="col" property="difunto"
											  title="${message(code: 'autor.difunto.label', default: 'Difunto')}" />

							<g:sortableColumn scope="col" property="imageAutor"
											  title="${message(code: 'autor.imagen.label', default: 'Ruta Imagen')}" />
							<%-- Este Th es solo para estetica --%>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${autorInstanceList}" status="i" var="autorInstance">
							<tr>

								<td>
									<g:link action="show" id="${autorInstance.id}">
										${fieldValue(bean: autorInstance, field: "nombre")}
									</g:link>
								</td>

								<td>
									<g:link action="show" id="${autorInstance.id}">
										${fieldValue(bean: autorInstance, field: "apellido")}
									</g:link>
								</td>

								<td>
									<g:formatDate format="dd/MM/yyyy" date="${autorInstance.fechaNacimento}"/>
								</td>

								<td>
									<g:country code="${autorInstance.nacionalidad}"/>
								</td>

								<td>
									<g:message code="autores.estado.${autorInstance?.genero}"/>
								</td>

								<td>
									<g:if test="${!autorInstance.difunto}">
										<g:message code="autores.estado.vivo" default="Vivo" />
									</g:if>
									<g:else>
										<g:message code="autores.estado.muerto" default="Muerto" />
									</g:else>
								</td>

								<td>
									<g:if test="${!autorInstance.imageAutor}">
										<g:message code="autor.rutaImagen.label.noFoto"
												   default="No hay Foto" />
									</g:if>
									<g:else>
										<g:message code="autor.rutaImagen.label.siFoto"
												   default="Tiene Foto" />
									</g:else>
								</td>

								<td>
									<g:link class="button small" action="show" id="${autorInstance.id}">
										<g:message code="default.list.show.label" args="[entityName]" />
									</g:link>
								</td>

							</tr>
						</g:each>
					</tbody>
				</table>
			</div>

			<g:if test="${flash.warn}">
				<div class="flash warn iconoWarning media" role="status">
					${flash.warn}
				</div>
			</g:if>

			<div class="col-sm-12 text-center ${autorInstanceCount <= 10 ? 'hidden':''}">
				<div class="pagination">
					<g:paginate total="${autorInstanceCount ?: 0}" params="${params}" />
				</div>
			</div>

		</section>
	</body>
</html>
