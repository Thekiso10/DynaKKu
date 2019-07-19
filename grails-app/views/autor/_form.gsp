<%@ page import="Colecciones.Autor" %>



<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'apellido', 'error')} required">
	<label for="apellido">
		<g:message code="autor.apellido.label" default="Apellido" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="apellido" required="" value="${autorInstance?.apellido}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'difunto', 'error')} required">
	<label for="difunto">
		<g:message code="autor.difunto.label" default="Difunto" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="difunto" type="number" value="${autorInstance.difunto}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'edad', 'error')} required">
	<label for="edad">
		<g:message code="autor.edad.label" default="Edad" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="edad" type="number" value="${autorInstance.edad}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'fechaInscripcion', 'error')} required">
	<label for="fechaInscripcion">
		<g:message code="autor.fechaInscripcion.label" default="Fecha Inscripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fechaInscripcion" precision="day"  value="${autorInstance?.fechaInscripcion}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="autor.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" required="" value="${autorInstance?.nombre}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'rutaImagen', 'error')} required">
	<label for="rutaImagen">
		<g:message code="autor.rutaImagen.label" default="Ruta Imagen" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="rutaImagen" required="" value="${autorInstance?.rutaImagen}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'ultimaModificacion', 'error')} required">
	<label for="ultimaModificacion">
		<g:message code="autor.ultimaModificacion.label" default="Ultima Modificacion" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="ultimaModificacion" precision="day"  value="${autorInstance?.ultimaModificacion}"  />

</div>

