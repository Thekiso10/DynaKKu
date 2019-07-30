<%@ page import="Colecciones.Autor" %>


<div class="col-sm-6">
	
	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'nombre', 'error')} required row">
		<label for="nombre" class="col-sm-3 text-right">
			<g:message code="autor.nombre.label" default="Nombre" />
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-9">
			<g:textField name="nombre" required="" value="${autorInstance?.nombre}" class="tamanoInput"/>
		</div>
	</div>
	
	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'apellido', 'error')} required row">
		<label for="apellido" class="col-sm-3 text-right">
			<g:message code="autor.apellido.label" default="Apellido" />
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-9">
			<g:textField name="apellido" required="" value="${autorInstance?.apellido}" class="tamanoInput"/>
		</div>
	</div>
	
	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'edad', 'error')} required row">
		<label for="edad" class="col-sm-3 text-right">
			<g:message code="autor.edad.label" default="Edad" />
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-9">
			<g:field name="edad" type="number" value="${autorInstance.edad}" required="" class="tamanoInput"/>
		</div>
	</div>
	
</div>

<div class="col-sm-6">

	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'difunto', 'error')} required row">
		<label for="difunto" class="col-sm-4 text-right">
			<g:message code="autor.difunto.label" default="Difunto"/>
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-8">
			<g:field name="difunto" type="number" value="${autorInstance.difunto}" required="" class="tamanoInput"/>
		</div>
	</div>
	
	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'nacionalidad', 'error')} required row">
		<label for="difunto" class="col-sm-4 text-right">
			<g:message code="autor.difunto.label" default="Nacionalidad"/>
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-8">
			<g:countrySelect name="difunto" value="${autorInstance.nacionalidad}" noSelection="['':'Escoge la nacionalidad del Autor']" required="" class="tamanoInput"/>
		</div>
	</div>
	
	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'rutaImagen', 'error')} required row">
		<label for="rutaImagen" class="col-sm-4 text-right">
			<g:message code="autor.rutaImagen.label" default="Ruta Imagen"/>
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-8">
			<g:textField name="rutaImagen" required="" value="${autorInstance?.rutaImagen}" class="tamanoInput"/>
		</div>
	</div>

</div>