<%@ page import="Colecciones.Autor" %>


<div class="col-sm-6">
	
	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'nombre', 'error')} required row">
		<label for="nombre" class="col-sm-4 text-right">
			<g:message code="autor.nombre.label" default="Nombre" />
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-8">
			<g:textField name="nombre" required="" value="${autorInstance?.nombre}" class="tamanoInput"/>
		</div>
	</div>
	
	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'apellido', 'error')} required row">
		<label for="apellido" class="col-sm-4 text-right">
			<g:message code="autor.apellido.label" default="Apellido" />
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-8">
			<g:textField name="apellido" required="" value="${autorInstance?.apellido}" class="tamanoInput"/>
		</div>
	</div>

	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'fechaNacimento', 'error')} required row">
		<label for="fechaDeNacimento" class="col-sm-4 text-right">
				<g:message code="autor.fechaNacimento.label" default="Edad" />
				<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-8">
			<g:set var="fecha" value="${autorInstance?.fechaNacimento ? g.formatDate(['format': 'dd/MM/yy', 'date': autorInstance?.fechaNacimento]) : ''}"/>
			<input type="text" id="fechaDeNacimento" name="fechaDeNacimento" value="${fecha}" required="" class="datepicker tamanoInput" size="10" data-date-format="dd/MM/yyyy" placeholder="${message(code:'autor.fechaNacimento.label')}"/>
		</div>
	</div>

	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'genero', 'error')} required row">
		<label for="genero" class="col-sm-4 text-right">
			<g:message code="autor.genero.label" default="Genero"/>
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-8">
			<select name="genero" id="genero">
				<option value="Masculino" ${autorInstance?.genero == 'Masculino' ? 'selected="selected"':''}><g:message code="autores.estado.masculino" default="masculino" /></option>
				<option value="Femenino" ${autorInstance?.genero == 'Femenino' ? 'selected="selected"':''}><g:message code="autores.estado.femenido" default="femenido" /></option>
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
				<option value="false" ${autorInstance?.difunto == false ? 'selected="selected"':''}><g:message code="autores.estado.vivo" default="vivo" /></option>
				<option value="true" ${autorInstance?.difunto == true ? 'selected="selected"':''}><g:message code="autores.estado.muerto" default="muerto" /></option>
			</select>
		</div>
	</div>
	
	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'nacionalidad', 'error')} required row">
		<label for="nacionalidad" class="col-sm-4 text-right">
			<g:message code="autor.nacionalidad.label" default="Nacionalidad"/>
			<span class="required-indicator">*</span>
		</label>
		<div class="col-sm-8">
			<g:countrySelect name="nacionalidad" value="${autorInstance.nacionalidad}" noSelection="['':'Escoge la nacionalidad del Autor']" required="" class="tamanoInput"/>
		</div>
	</div>
	
	<div class="fieldcontain ${hasErrors(bean: autorInstance, field: 'imagen', 'error')} row">
		<label for="imagen" class="col-sm-4 text-right">
			<g:message code="autor.imagen.label" default="Ruta Imagen"/>
		</label>
		<g:if test="${!autorInstance?.rutaImagen}">	
			<div class="col-sm-8">
				<g:field type="file" name="imagen" id="imgAutor" accept="image/*" class="tamanoInput"/>
			  	<div class="imgAutorInfo small">
			  		<span>
			  			<g:message code="autores.imagen.formatos"/>
			  		</span>
			  	</div>
			</div>
		</g:if>
		<g:else>
			<div class="col-sm-8 checkboxImg">
				<g:hiddenField name="checkImg" value="${true}"/>
				<g:checkBox name="CheckboxImg" />
				<span>
		  			<g:message code="autores.imagen.checBoxDelete"/>
		  		</span>
			</div>
		</g:else>
	</div>
	
	
</div>