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
	
	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'nacionalidad', 'error')} required row">
		<label for="genero" class="col-sm-3 text-right">
			<g:message code="autor.genero.label" default="Genero"/>
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-9">
			<select name="genero" id="genero">
				<option value="1">Masculino</option>
				<option value="0">Femenido</option>
			</select>
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
			<select name="difunto" id="difunto">
				<option value="1">Vivo</option>
				<option value="0">Muerto</option>
			</select>
		</div>
	</div>
	
	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'nacionalidad', 'error')} required row">
		<label for="nacionalidad" class="col-sm-4 text-right">
			<g:message code="autor.difunto.label" default="Nacionalidad"/>
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-8">
			<g:countrySelect name="nacionalidad" value="${autorInstance.nacionalidad}" noSelection="['':'Escoge la nacionalidad del Autor']" required="" class="tamanoInput"/>
		</div>
	</div>
	
	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'rutaImagen', 'error')} required row">
		<label for="rutaImagen" class="col-sm-4 text-right">
			<g:message code="autor.rutaImagen.label" default="Ruta Imagen"/>
		</label>
		<div class="col-sm-8">
			<g:field type="file" name="rutaImagen" id="imgAutor" accept="image/*" class="tamanoInput"/>
		  	<div class="imgAutorInfo small">
		  		<span>
		  			<g:message code="autores.imagen.formatos"/>
		  		</span>
		  	</div>
		</div>
	</div>
</div>