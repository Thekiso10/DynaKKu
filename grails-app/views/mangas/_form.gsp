<%@ page import="Colecciones.Mangas" %>
<%@ page import="Colecciones.Demografia" %>


<h3><g:message code="mangas.title.datosManga" /></h3>
<div class="col-sm-12 blockManga">
	<div class="col-sm-12 row">

		<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'nombreManga', 'error')} col-sm-6">
			<label for="nombreManga" class="col-sm-4">
				<g:message code="mangas.nombreManga.label" default="Nombre Manga" />:
			</label>
			<g:textField class="col-sm-8" name="nombreManga" value="${mangasInstance?.nombreManga}"/>
		</div>


		<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'urlImg', 'error')} col-sm-6">
			<label for="urlImg" class="col-sm-4">
				<g:message code="mangas.urlImg.label" default="Url Img" />:
			</label>
			<g:field type="file" name="urlImg"  accept="image/*" class="tamanoInput col-sm-8"/>
			<div class="imgAutorInfo small">
				<span>
					<g:message code="autores.imagen.formatos" default="Url Img" />
				</span>
			</div>
		</div>

	</div>


	<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'autor', 'error')} col-sm-12">
		<label id="autorLabel" for="autor" class="col-sm-2">
			<g:message code="layoutMenu.botonesColeccion.autor" default="Autor" />:
		</label>
		<g:select id="autor" name="autor.id" from="${Colecciones.Autor.list()}" optionKey="id" optionValue="${{it.nombre + " " +it.apellido}}" value="${mangasInstance?.autor?.id}" class="many-to-one col-sm-10" noSelection="['null': '']"/>
	</div>
</div>

<h3><g:message code="mangas.title.datosSerie"/></h3>
<div class="col-sm-12 blockManga">

	<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'completado', 'error')} col-sm-3 text-center">
		<label for="completado">
			<g:message code="mangas.completado.label" default="Completado" />

		</label>
		<g:checkBox name="completado" value="${mangasInstance?.completado}" class="checkboxPos"/>

	</div>

	<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'serieAcabada', 'error')} col-sm-3 text-center">
		<label for="serieAcabada">
			<g:message code="mangas.serieAcabada.label" default="Serie Acabada" />

		</label>
		<g:checkBox name="serieAcabada" value="${mangasInstance?.serieAcabada}" class="checkboxPos"/>

	</div>

	<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'serieConsecutiva', 'error')} col-sm-3 text-center">
		<label for="serieConsecutiva">
			<g:message code="mangas.serieConsecutiva.label" default="Serie Consecutiva" />

		</label>
		<g:checkBox name="serieConsecutiva" value="${mangasInstance?.serieConsecutiva}" class="checkboxPos"/>

	</div>

	<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'deseado', 'error')} col-sm-3 text-center">
		<label for="deseado">
			<g:message code="mangas.deseado.label" default="Deseado" />

		</label>
		<g:checkBox name="deseado" value="${mangasInstance?.deseado}" class="checkboxPos"/>

	</div>

</div>

<h3><g:message code="mangas.title.datosMonetarios" /></h3>
<div class="col-sm-12 blockManga">

	<div class="col-sm-12 row">
		<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'numTomosActuales', 'error')} required col-sm-6">
			<label for="numTomosActuales" class="col-sm-5">
				<g:message code="mangas.numTomosActuales.label" default="Num Tomos Actuales" />
				<span class="required-indicator">*</span>
			</label>
			<g:field class="col-sm-7" name="numTomosActuales" type="number" value="${mangasInstance.numTomosActuales}" required=""/>

		</div>

		<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'numTomosMaximos', 'error')} required col-sm-6">
			<label for="numTomosMaximos" class="col-sm-6">
				<g:message code="mangas.numTomosMaximos.label" default="Num Tomos Maximos" />
				<span class="required-indicator">*</span>
			</label>
			<g:field class="col-sm-6" name="numTomosMaximos" type="number" value="${mangasInstance.numTomosMaximos}" required=""/>

		</div>
	</div>

	<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'precioTotal', 'error')} required col-sm-12">
		<label for="precioTotal" class="col-sm-3" id="precioTotalLabel">
			<g:message code="mangas.precioTotal.label" default="Precio Total" />
			<span class="required-indicator">*</span>
		</label>
		<g:field class="col-sm-9" name="precioTotal" type="number" value="${mangasInstance.precioTotal}" required=""/>

	</div>
</div>

<h3><g:message code="mangas.title.datosGenero" /></h3>
<div class="col-sm-12 blockManga">
	<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'demografia', 'error')} required col-sm-6 text-center">
		<label for="demografia">
			<g:message code="mangas.demografia.label" default="Demografia" />
			<span class="required-indicator">*</span>
		</label>
		<g:select id="demografia" name="demografia.nombre" from="${Demografia.list()}" optionKey="id" optionValue="nombre" value="${mangasInstance?.demografia?.nombre}" class="many-to-one" noSelection="['null': '']" />

	</div>

	<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'Generos', 'error')} required col-sm-6 text-center">
		<label for="Generos">
			<g:message code="mangas.Generos.label" default="Generos" />
			<span class="required-indicator">*</span>
		</label>
		<g:select id="Generos" name="Generos.id" from="${Colecciones.Genero.list()}" optionKey="id" optionValue="nombre" class="many-to-one" noSelection="['null': '']"/>
	</div>

</div>
