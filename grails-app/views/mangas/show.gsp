
<%@ page import="Colecciones.Mangas" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain">
		<g:set var="entityName" value="${message(code: 'layoutMenu.botonesColeccion.manga', default: 'Mangas')}" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mangas.css')}" type="text/css">
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="ver-manga" class="col-sm-12" role="main">
            <div class="menu navbar-collapse" role="navigation">
                <div class="container">
                    <ul class="navbar-nav">
                        <li><g:link class="btn btnSaveV2" action="edit" resource="${mangasInstance}"><g:message code="default.button.update.label" args="[entityName]"/></g:link></li>
                    </ul>
                    <ul class="navbar-nav">
                        <li class="dropdown">
                            <a href="#" class="btn btnExtra" onclick="modificarIconoMenu(this)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                <span class="glyphicon glyphicon-chevron-down"></span>
                                <g:message code="mangas.list.label" />
                            </a>
                            <ul class="dropdown-menu styleDropdown">
                                <li><g:link class="btn btnMenu" controller="mangas" action="index" params="[registrado: true]"><g:message code="mangas.list.registrados.label" /></g:link></li>
                                <li><g:link class="btn btnMenu" controller="mangas" action="index" params="[registrado: false]"><g:message code="mangas.list.deseados.label" /></g:link></li>
                            </ul>
                        </li>
                    </ul>
                    <ul class="navbar-nav">
                        <li class="dropdown">
                            <a href="#" class="btn btnExtra" onclick="modificarIconoMenu(this)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                <span class="glyphicon glyphicon-chevron-down"></span>
                                <g:message code="layoutMenu.botonesColeccion.funciones" />
                            </a>
                            <ul class="dropdown-menu styleDropdown">
                                <g:if test="${mangasInstance?.deseado}">
                                    <li><button class="btn btnMenu" data-toggle="modal" data-target="#modalPassDeseadoToRegister"><g:message code="mangas.list.pass.deseadoToRegister"/></button></li>
                                </g:if>
                                <g:else>
                                    <li><button class="btn btnMenu" data-toggle="modal" data-target="#modalSumTomosManga"><g:message code="mangas.show.sumTomos.label"/></button></li>
                                </g:else>
                                <li><button class="btn btnMenu" data-toggle="modal" data-target="#modalUpdateSpinOff"><g:message code="mangas.show.spinOff.updateState"/></button></li>
                            </ul>
                        </li>
                    </ul>
                    <g:form url="[resource:mangasInstance, action:'delete']" method="DELETE">
                        <ul class="navbar-nav navbar-right">
							<li><g:actionSubmit class="btn btnDelete" action="delete" value="${message(code: 'mangas.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');" /></li>
                            <li><a href="#" class="btn btnSkip" tabindex="-1" onclick="history.back()"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a></li>
                        </ul>
                    </g:form>
                </div>
            </div>

			<div class="container">
				<g:if test="${flash.message}">
					<div class="flash mensajes iconoMensajes" role="status">${flash.message}</div>
				</g:if>

				<g:if test="${flash.error}">
					<div class="flash errors iconoError" role="status">${flash.error}</div>
				</g:if>

				<h2>
					<g:message code="default.show.label" args="[entityName]" />
				</h2>

				<div id="panel-ver-mangas" class="panel-show-mangas row">
					<h3>${mangasInstance?.nombreManga}</h3>

					<div id="imgMangas" class="col-sm-3">
						<g:if test="${mangasInstance?.urlImg}">
							<img class="img-responsive" src="${createLink(controller:'mangas', action:'poster_image', id:mangasInstance.id)}" alt="${mangasInstance?.nombreManga}"/>
						</g:if>
						<g:else>
							<g:img class="img-responsive" dir="images/imgWeb" file="mangaSinPoster.png"/>
						</g:else>
					</div>

					<div class="col-sm-9">

						<div class="infoMangas col-sm-12">
							<h3>
								<g:message code="mangas.title.datosManga"/>
							</h3>

							<g:if test="${mangasInstance?.nombreManga}">
								<div class="col-sm-6">
									<div class="row">
										<h4 id="nombreManga-label" class="property-label col-sm-4"><g:message code="autor.nombre.label" default="nombre" />:</h4>
										<span class="property-value col-sm-8" aria-labelledby="nombreManga-label"><g:fieldValue bean="${mangasInstance}" field="nombreManga"/></span>
									</div>
								</div>
							</g:if>

							<g:if test="${mangasInstance?.autor}">
								<div class="col-sm-6">
									<div class="row">
										<h4 id="autor-label" class="property-label col-sm-3"><g:message code="layoutMenu.botonesColeccion.autor" default="autor" />:</h4>
										<span id="autorSpan-label" class="property-value col-sm-9" aria-labelledby="autor-label">
											<g:link controller="autor" action="show" id="${mangasInstance.autor?.id}">${mangasInstance.autor.toString()}</g:link>
										</span>
									</div>
								</div>
							</g:if>
						</div>

						<div class="infoMangas col-sm-12">
							<h3>
								<g:message code="mangas.title.datosSerie"/>
							</h3>

							<g:if test="${mangasInstance?.completado != null}">
								<div class="col-sm-6">
									<div class="row">
										<h4 id="completado-label" class="property-label col-sm-8"><g:message code="mangas.completado.label" default="autor" />:</h4>
										<span class="property-value col-sm-4 glyphicon ${mangasInstance?.completado ? 'glyphicon-ok' : 'glyphicon-remove'}" aria-labelledby="completado-label"></span>
									</div>
								</div>
							</g:if>

							<g:if test="${mangasInstance?.serieAcabada != null}">
								<div class="col-sm-6">
									<div class="row">
										<h4 id="serieAcabada-label" class="property-label col-sm-7"><g:message code="mangas.serieAcabada.label" default="autor" />:</h4>
										<span class="property-value col-sm-5 glyphicon ${mangasInstance?.serieAcabada ? 'glyphicon-ok' : 'glyphicon-remove'}" aria-labelledby="serieAcabada-label"></span>
									</div>
								</div>
							</g:if>

							<g:if test="${mangasInstance?.serieConsecutiva != null}">
								<div class="col-sm-6">
									<div class="row">
										<h4 id="serieConsecutiva-label" class="property-label col-sm-8"><g:message code="mangas.serieConsecutiva.label" default="autor" />:</h4>
										<span class="property-value col-sm-4 glyphicon ${mangasInstance?.serieConsecutiva ? 'glyphicon-ok' : 'glyphicon-remove'}" aria-labelledby="serieConsecutiva-label"></span>
									</div>
								</div>
							</g:if>

							<g:if test="${mangasInstance?.deseado != null}">
								<div class="col-sm-6">
									<div class="row">
										<h4 id="deseado-label" class="property-label col-sm-7"><g:message code="mangas.deseado.label" default="autor" />:</h4>
										<span class="property-value col-sm-5 glyphicon ${mangasInstance?.deseado ? 'glyphicon-ok' : 'glyphicon-remove'}" aria-labelledby="deseado-label"></span>
									</div>
								</div>
							</g:if>

                            <div class="col-sm-12 Box-SpinOff">
                                <div class="row">
                                    <h4 id="spinOff-label" class="property-label col-sm-2"><g:message code="mangas.spinOff.label" default="autor" />:</h4>
                                    <g:if test="${mangasInstance?.mangaSpinOff}">
                                        <span class="property-value col-sm-10" aria-labelledby="spinOff-label">
                                            <g:link controller="mangas" action="show" id="${mangasInstance?.mangaSpinOff?.id}">${mangasInstance?.mangaSpinOff?.nombreManga}</g:link>
                                        </span>
                                    </g:if>
                                    <g:else>
                                        <span class="property-value col-sm-10 italic" aria-labelledby="spinOff-label">
                                            <g:message code="mangas.show.spinOff.noRegister"/>
                                        </span>
                                    </g:else>
                                </div>
                            </div>

						</div>

						<g:if test="${!mangasInstance?.deseado}">
							<div class="infoMangas col-sm-12">
								<h3>
									<g:message code="mangas.title.datosMonetarios"/>
								</h3>

								<g:if test="${mangasInstance?.numTomosActuales}">
									<div class="col-sm-6">
										<div class="row">
											<h4 id="numTomosActuales-label" class="property-label col-sm-8"><g:message code="mangas.numTomosActuales.label" default="nombre" />:</h4>
											<span class="property-value col-sm-4 number" aria-labelledby="numTomosActuales-label"><g:fieldValue bean="${mangasInstance}" field="numTomosActuales"/></span>
										</div>
									</div>
								</g:if>

								<g:if test="${mangasInstance?.numTomosMaximos}">
									<div class="col-sm-6">
										<div class="row">
											<h4 id="numTomosMaximos-label" class="property-label col-sm-10"><g:message code="mangas.numTomosMaximos.label" default="nombre" />:</h4>
											<span class="property-value col-sm-2 number" aria-labelledby="numTomosMaximos-label"><g:fieldValue bean="${mangasInstance}" field="numTomosMaximos"/></span>
										</div>
									</div>
								</g:if>

								<g:if test="${mangasInstance?.precioTotal}">
									<div class="col-sm-6">
										<div class="row">
											<h4 id="precioTotal-label" class="property-label col-sm-8"><g:message code="mangas.precioTotal.label" default="nombre" />:</h4>
											<span class="property-value col-sm-4 number" aria-labelledby="precioTotal-label"><g:fieldValue bean="${mangasInstance}" field="precioTotal"/>€</span>
										</div>
									</div>
								</g:if>
							</div>
						</g:if>

						<div class="infoMangas last-box col-sm-12">
							<h3>
								<g:message code="mangas.title.datosGenero"/>
							</h3>

							<g:if test="${mangasInstance?.demografia}">
								<div class="col-sm-12">
									<div class="row">
										<h4 id="demografia-label" class="property-label col-sm-3"><g:message code="mangas.demografia.label" default="nombre" />:</h4>
										<span class="property-value col-sm-9" aria-labelledby="demografia-label"><g:fieldValue bean="${mangasInstance}" field="demografia.nombre"/></span>
									</div>
								</div>
							</g:if>

							<g:if test="${listaGeneros}">
								<div class="col-sm-12">
									<div class="row">
										<h4 id="generos-label" class="property-label col-sm-3"><g:message code="mangas.generos.label" default="nombre" />:</h4>
										<div class="col-sm-8 marginGenero">
											<g:each in="${listaGeneros}" var="genero">
												<span class="box-genero">
													${genero?.genero?.nombre} |
												</span>
											</g:each>
										</div>
									</div>
								</div>
							</g:if>

						</div>

					</div>
				</div>
			</div>

            <div id="modalPassDeseadoToRegister" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <g:render template="templates/modalDeseadoToRegister"/>
            </div>

            <div id="modalSumTomosManga" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <g:render template="templates/modalSumTomosManga"/>
            </div>

			<div id="modalUpdateSpinOff" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<g:render template="templates/modalUpdateSpinOff"/>
			</div>

		</div>
	</body>
</html>
