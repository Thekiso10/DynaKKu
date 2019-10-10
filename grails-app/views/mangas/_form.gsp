<%@ page import="Colecciones.Mangas" %>



<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'nombreManga', 'error')} ">
	<label for="nombreManga">
		<g:message code="mangas.nombreManga.label" default="Nombre Manga" />
		
	</label>
	<g:textField name="nombreManga" value="${mangasInstance?.nombreManga}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'urlImg', 'error')} ">
	<label for="urlImg">
		<g:message code="mangas.urlImg.label" default="Url Img" />
		
	</label>
	<g:textField name="urlImg" value="${mangasInstance?.urlImg}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'completado', 'error')} ">
	<label for="completado">
		<g:message code="mangas.completado.label" default="Completado" />
		
	</label>
	<g:checkBox name="completado" value="${mangasInstance?.completado}" />

</div>

<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'serieAcabada', 'error')} ">
	<label for="serieAcabada">
		<g:message code="mangas.serieAcabada.label" default="Serie Acabada" />
		
	</label>
	<g:checkBox name="serieAcabada" value="${mangasInstance?.serieAcabada}" />

</div>

<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'serieConsecutiva', 'error')} ">
	<label for="serieConsecutiva">
		<g:message code="mangas.serieConsecutiva.label" default="Serie Consecutiva" />
		
	</label>
	<g:checkBox name="serieConsecutiva" value="${mangasInstance?.serieConsecutiva}" />

</div>

<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'deseado', 'error')} ">
	<label for="deseado">
		<g:message code="mangas.deseado.label" default="Deseado" />
		
	</label>
	<g:checkBox name="deseado" value="${mangasInstance?.deseado}" />

</div>

<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'numTomosActuales', 'error')} required">
	<label for="numTomosActuales">
		<g:message code="mangas.numTomosActuales.label" default="Num Tomos Actuales" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="numTomosActuales" type="number" value="${mangasInstance.numTomosActuales}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'numTomosMaximos', 'error')} required">
	<label for="numTomosMaximos">
		<g:message code="mangas.numTomosMaximos.label" default="Num Tomos Maximos" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="numTomosMaximos" type="number" value="${mangasInstance.numTomosMaximos}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'precioTotal', 'error')} required">
	<label for="precioTotal">
		<g:message code="mangas.precioTotal.label" default="Precio Total" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="precioTotal" type="number" value="${mangasInstance.precioTotal}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'fechaInscripcion', 'error')} ">
	<label for="fechaInscripcion">
		<g:message code="mangas.fechaInscripcion.label" default="Fecha Inscripcion" />
		
	</label>
	<g:datePicker name="fechaInscripcion" precision="day"  value="${mangasInstance?.fechaInscripcion}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'ultimaModificacion', 'error')} ">
	<label for="ultimaModificacion">
		<g:message code="mangas.ultimaModificacion.label" default="Ultima Modificacion" />
		
	</label>
	<g:datePicker name="ultimaModificacion" precision="day"  value="${mangasInstance?.ultimaModificacion}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'autor', 'error')} ">
	<label for="autor">
		<g:message code="mangas.autor.label" default="Autor" />
		
	</label>
	<g:select id="autor" name="autor.id" from="${Colecciones.Autor.list()}" optionKey="id" value="${mangasInstance?.autor?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'demografia', 'error')} ">
	<label for="demografia">
		<g:message code="mangas.demografia.label" default="Demografia" />
		
	</label>
	<g:select id="demografia" name="demografia.id" from="${Colecciones.Demografia.list()}" optionKey="id" value="${mangasInstance?.demografia?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: mangasInstance, field: 'mangaSpinOff', 'error')} ">
	<label for="mangaSpinOff">
		<g:message code="mangas.mangaSpinOff.label" default="Manga Spin Off" />
		
	</label>
	<g:select id="mangaSpinOff" name="mangaSpinOff.id" from="${Colecciones.Mangas.list()}" optionKey="id" value="${mangasInstance?.mangaSpinOff?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

