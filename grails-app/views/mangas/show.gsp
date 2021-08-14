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
		<section id="ver-manga">

			<nav class="navbar navbar-default">
				<div class="container-fluid">

					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-manga-show" aria-expanded="false">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
					</div>
					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse" id="navbar-manga-show">
						<ul class="nav navbar-nav">
							<li>
								<div>
									<g:link class="button" action="edit" resource="${mangasInstance}">
										<g:message code="default.button.update.label" args="[entityName]"/>
									</g:link>

									<g:if test="${mangasInstance?.deseado}">
										<button class="button" data-toggle="modal" data-target="#modalPassDeseadoToRegister">
											<g:message code="mangas.list.pass.deseadoToRegister"/>
										</button>
									</g:if>
									<g:else>
										<button class="button" data-toggle="modal" data-target="#modalSumTomosManga">
											<g:message code="mangas.show.sumTomos.label"/>
										</button>
									</g:else>

									<button class="button" data-toggle="modal" data-target="#modalUpdateSpinOff">
										<g:message code="mangas.show.spinOff.updateState"/>
									</button>
								</div>
							</li>
						</ul>

						<ul class="nav navbar-nav navbar-right">
							<li>
								<div>
									<g:link class="button btn-danger" controller="mangas" action="delete" resource="${mangasInstance}"
											onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');">
										<g:message code='mangas.delete.label' default='Delete'/>
									</g:link>
								</div>
							</li>

							<li>
								<a href="#" class="button primary" tabindex="-1" onclick="history.back()">
									<g:message code="default.link.skip.label" default="Skip to content&hellip;"/>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</nav>


			<g:if test="${flash.message}">
				<div class="flash mensajes iconoMensajes" role="status">${flash.message}</div>
			</g:if>

			<g:if test="${flash.error}">
				<div class="flash errors iconoError" role="status">${flash.error}</div>
			</g:if>

			<header class="main">
				<h1>
					<g:message code="default.show.label" args="[entityName]" /> -
					${mangasInstance?.nombreManga}
				</h1>
			</header>

			<div class="features">
				%{-- Datos Genereales mas Imagen --}%
				<article>

					<span id="imgMangas" class="image icon">
						<g:if test="${mangasInstance?.urlImg}">
							<img class="img-responsive" src="${createLink(controller:'mangas', action:'poster_image', id:mangasInstance.id)}" alt="${mangasInstance?.nombreManga}"/>
						</g:if>
						<g:else>
							<g:img class="img-responsive" dir="images/imgWeb" file="mangaSinPoster.png"/>
						</g:else>
					</span>

					<div class="content">
						<header class="major">
							<h2>
								<g:message code="mangas.title.datosManga"/>
							</h2>
						</header>

						<p>
							<g:message code="autor.nombre.label" default="nombre" />:
							<span aria-labelledby="nombreManga-label"><g:fieldValue bean="${mangasInstance}" field="nombreManga"/></span>
						</p>

						<p>
							<g:message code="layoutMenu.botonesColeccion.autor" default="autor" />:
							<span aria-labelledby="autor-label">
								<g:link controller="autor" action="show" id="${mangasInstance.autor?.id}">${mangasInstance.autor.toString()}</g:link>
							</span>
						</p>

						<p>
							<g:message code="mangas.spinOff.label" default="autor" />:
							<g:if test="${mangasInstance?.mangaSpinOff}">
								<span aria-labelledby="spinOff-label">
									<g:link controller="mangas" action="show" id="${mangasInstance?.mangaSpinOff?.id}">${mangasInstance?.mangaSpinOff?.nombreManga}</g:link>
								</span>
							</g:if>
							<g:else>
								<span class="italic" aria-labelledby="spinOff-label">
									<g:message code="mangas.show.spinOff.noRegister"/>
								</span>
							</g:else>
						</p>
					</div>

				</article>

				%{-- Datos Especificos Personales --}%
				<article>
					<span class="icon icon-article fas fa-id-card"></span>
					<div class="content">
						<header class="major">
							<h2>
								<g:message code="mangas.title.datosSerie"/>
							</h2>
						</header>

						<p>
							<g:message code="mangas.serieAcabada.label" default="autor" />:
							<span class="glyphicon ${mangasInstance?.serieAcabada ? 'glyphicon-ok' : 'glyphicon-remove'}" aria-labelledby="serieAcabada-label"></span>
						</p>

						<g:if test="${!mangasInstance?.deseado}">
							<p>
								<g:message code="mangas.completado.label" default="autor" />:
								<span class="glyphicon ${mangasInstance?.completado ? 'glyphicon-ok' : 'glyphicon-remove'}" aria-labelledby="completado-label"></span>
							</p>

							<p>
								<g:message code="mangas.serieConsecutiva.label" default="autor" />:
								<span class="glyphicon ${mangasInstance?.serieConsecutiva ? 'glyphicon-ok' : 'glyphicon-remove'}" aria-labelledby="serieConsecutiva-label"></span>
							</p>
						</g:if>

						<g:if test="${mangasInstance?.deseado}">
							<p>
								<g:message code="mangas.deseado.label" default="autor" />:
								<span class="glyphicon glyphicon-ok" aria-labelledby="deseado-label"></span>
							</p>
						</g:if>
					</div>
				</article>

				%{-- Datos Monetarios --}%
				<g:if test="${!mangasInstance?.deseado}">
					<article class="${!mangasInstance?.deseado ? 'move-article' : ''}">
						<span class="icon icon-article solid fa-money-check-alt"></span>
						<div class="content">
							<header class="major">
								<h2>
									<g:message code="mangas.title.datosMonetarios"/>
								</h2>
							</header>

							<p>
								<g:message code="mangas.numTomosActuales.label" default="nombre" />:
								<span aria-labelledby="numTomosActuales-label">
									${mangasInstance.numTomosActuales}
								</span>
							</p>

							<p>
								<g:message code="mangas.numTomosMaximos.label" default="nombre" />:
								<span aria-labelledby="numTomosMaximos-label">
									${mangasInstance.numTomosMaximos}
								</span>
							</p>

							<p>
								<g:message code="mangas.precioTotal.label" default="nombre" />:
								<span aria-labelledby="precioTotal-label">
									${mangasInstance.precioTotal}€
								</span>
							</p>
						</div>
					</article>
				</g:if>

				%{-- Generos y Demografia --}%
				<article class="${mangasInstance?.deseado ? 'move-article' : ''}">
					<span class="icon icon-article solid fa-dragon"></span>
					<div class="content">
						<header class="major">
							<h2>
								<g:message code="mangas.title.datosGenero"/>
							</h2>
						</header>

						<p>
							<g:message code="mangas.demografia.label" default="nombre" />:
							<span aria-labelledby="demografia-label">
								<g:fieldValue bean="${mangasInstance}" field="demografia.nombre"/>
							</span>
						</p>

						<p>
							<g:message code="mangas.generos.label" default="nombre" />:
								<g:each in="${listaGeneros}" var="genero">
									<span class="box-genero">
										${genero?.genero?.nombre} |
									</span>
								</g:each>
						</p>

					</div>
				</article>
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

		</section>
	</body>
</html>
