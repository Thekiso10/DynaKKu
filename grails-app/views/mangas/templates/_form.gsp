<%@ page import="Colecciones.Mangas" %>
<%@ page import="Colecciones.Demografia" %>

<header class="major col-12">
	<h3><g:message code="mangas.title.datosManga" /></h3>
</header>
<div class="col-4 col-12-xsmall ${hasErrors(bean: mangasInstance, field: 'nombreManga', 'error')}">
	<label for="nombreManga">
		<g:message code="mangas.nombreManga.label" default="Nombre Manga" />:
	</label>
	<g:textField name="nombreManga" value="${mangasInstance?.nombreManga}"/>
</div>

<div class="col-4 col-12-xsmall ${hasErrors(bean: mangasInstance, field: 'autor', 'error')}">
	<label id="autorLabel" for="autor">
		<g:message code="layoutMenu.botonesColeccion.autor" default="Autor" />:
	</label>
	<g:select id="autor" name="autor.id" from="${Colecciones.Autor.findAllByBorrado(false)}"
			  optionKey="id" optionValue="${{it.nombre + " " +it.apellido}}" value="${mangasInstance?.autor?.id}"
			  class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="col-4 col-12-xsmall ${mangasInstance?.urlImg ? 'checkBox' : ''} ${hasErrors(bean: mangasInstance, field: 'urlImg', 'error')}">
	<g:if test="${!mangasInstance?.urlImg}">
		<label for="imagen">
			<g:message code="mangas.urlImg.label" default="Url Img" />:
		</label>
		<g:field type="file" name="imagen"  accept="image/*"/>
		<div class="small imgAutorInfo">
			<span>
				<g:message code="autores.imagen.formatos" default="Url Img" />
			</span>
		</div>
	</g:if>
	<g:else>
		<g:hiddenField name="checkImg" value="${true}"/>
		<g:checkBox name="CheckboxImg"/>
		<label for="CheckboxImg">
			<g:message code="mangas.message.checBoxDelete"/>
		</label>
	</g:else>
</div>

<header class="major col-12">
	<h3><g:message code="mangas.title.datosSerie"/></h3>
</header>

<div class="col-3 col-12-xsmall  ${hasErrors(bean: mangasInstance, field: 'completado', 'error')}">
	<g:checkBox name="completado" value="${mangasInstance?.completado}"/>
	<label for="completado">
		<g:message code="mangas.completado.label" default="Completado" />
	</label>
</div>

<div class="col-3 col-12-xsmall  ${hasErrors(bean: mangasInstance, field: 'serieAcabada', 'error')}">
	<g:checkBox name="serieAcabada" value="${mangasInstance?.serieAcabada}"/>
	<label for="serieAcabada">
		<g:message code="mangas.serieAcabada.label" default="Serie Acabada" />
	</label>
</div>

<div class="col-3 col-12-xsmall  ${hasErrors(bean: mangasInstance, field: 'serieConsecutiva', 'error')}">
	<g:checkBox name="serieConsecutiva" value="${mangasInstance?.serieConsecutiva}"/>
	<label for="serieConsecutiva">
		<g:message code="mangas.serieConsecutiva.label" default="Serie Consecutiva" />
	</label>
</div>

<div class="col-3 col-12-xsmall  ${hasErrors(bean: mangasInstance, field: 'deseado', 'error')}">
	<g:checkBox name="deseado" value="${mangasInstance?.deseado}" class="checkboxPos"/>
	<label for="deseado">
		<g:message code="mangas.deseado.label" default="Deseado" />
	</label>
</div>

<header class="major col-12">
	<h3><g:message code="mangas.title.datosMonetarios" /></h3>
</header>
<div class="col-4 col-12-xsmall required ${hasErrors(bean: mangasInstance, field: 'numTomosActuales', 'error')}">
	<label for="numTomosActuales">
		<g:message code="mangas.numTomosActuales.label" default="Num Tomos Actuales" />:
		<span class="required-indicator">*</span>
	</label>
	<g:field name="numTomosActuales" type="number" value="${mangasInstance.numTomosActuales}" required=""/>
</div>

<div class="col-4 col-12-xsmall ${hasErrors(bean: mangasInstance, field: 'numTomosMaximos', 'error')}">
	<label for="numTomosMaximos">
		<g:message code="mangas.numTomosMaximos.label" default="Num Tomos Maximos" />:
		<span class="required-indicator">*</span>
	</label>
	<g:field name="numTomosMaximos" type="number" value="${mangasInstance.numTomosMaximos}" required=""/>
</div>

<div class="col-4 col-12-xsmall ${hasErrors(bean: mangasInstance, field: 'precioTotal', 'error')} required">
	<label for="precioTotal" id="precioTotalLabel">
		<g:message code="mangas.precioTotal.label" default="Precio Total" />:
		<span class="required-indicator">*</span>
	</label>
	<g:field name="precioTotal" type="number" step=".01" value="${mangasInstance.precioTotal}" required=""/>
</div>

<header class="major col-12">
	<h3><g:message code="mangas.title.datosGenero" /></h3>
</header>
<div class="col-5 col-12-xsmall ${hasErrors(bean: mangasInstance, field: 'demografia', 'error')} required">
	<label for="demografia">
		<g:message code="mangas.demografia.label" default="Demografia" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="demografia" name="demografia.nombre" from="${Demografia.list()}"
			  optionKey="id" optionValue="nombre" value="${mangasInstance?.demografia?.id}"
			  class="many-to-one" noSelection="['null': '']" />
</div>

<div class="col-5 col-12-xsmall ${hasErrors(bean: mangasInstance, field: 'Generos', 'error')} required">
	<label for="Generos">
		<g:message code="mangas.generos.label" default="Generos" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="Generos" name="Generos.id" from="${Colecciones.Genero.list()}" optionKey="id" optionValue="nombre" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="col-2 col-12-xsmall button-genero-manga">
	<button id="agreeGenero" type="button" data-dismiss="modal">
		<g:message code="default.button.agree"/>
	</button>
</div>

<div id="boxesGeneros" class="col-12">

	<div id="clonBoxGenero" class="boxGenero hidden">
		<span class="boxNombreGenero"></span>
		<span class="close closeGenero" data-dismiss="modal">&times;</span>
	</div>

	<g:each in="${listaGeneros}" var="generoManga">
		<div id="${generoManga?.genero?.id}"  class="boxGenero">
			<span class="boxNombreGenero">${generoManga?.genero?.nombre}</span>
			<span class="close closeGenero" data-dismiss="modal">&times;</span>
		</div>
	</g:each>
</div>

<g:hiddenField name="listOfGenders" value=""/>