<%@ page import="Colecciones.Autor" %>

%{-- Nombre y Apellido --}%
<div class="col-6 col-12-xsmall fieldcontain ${hasErrors(bean: autorInstance, field: 'nombre', 'error')} required">
	<label for="nombre" class="text-right">
		<g:message code="autor.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" required="" value="${autorInstance?.nombre}"/>
</div>
<div class="col-6 col-12-xsmall fieldcontain ${hasErrors(bean: autorInstance, field: 'apellido', 'error')} required">
	<label for="apellido" class="text-right">
		<g:message code="autor.apellido.label" default="Apellido" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="apellido" required="" value="${autorInstance?.apellido}" class="tamanoInput"/>
</div>
%{-- Nacimiento, Genero, Difunto, Nacionalidad --}%
<div class="col-3 col-12-xsmall fieldcontain ${hasErrors(bean: autorInstance, field: 'fechaNacimento', 'error')} required">
	<label for="fechaDeNacimento" class="text-right">
		<g:message code="autor.fechaNacimento.label" default="Edad" />
		<span class="required-indicator">*</span>
	</label>
	<g:set var="fecha" value="${autorInstance?.fechaNacimento ? g.formatDate(['format': 'dd/MM/yy', 'date': autorInstance?.fechaNacimento]) : ''}"/>
	<input type="text" id="fechaDeNacimento" name="fechaDeNacimento" value="${fecha}" required="" class="datepicker tamanoInput" size="10" data-date-format="dd/MM/yyyy" placeholder="${message(code:'autor.fechaNacimento.label')}"/>
</div>

<div class="col-3 col-12-xsmall fieldcontain ${hasErrors(bean: autorInstance, field: 'genero', 'error')} required">
	<label for="genero" class="text-right">
		<g:message code="autor.genero.label" default="Genero"/>
		<span class="required-indicator">*</span>
	</label>
	<select name="genero" id="genero">
		<option value="Masculino" ${autorInstance?.genero == 'Masculino' ? 'selected="selected"':''}><g:message code="autores.estado.masculino" default="masculino" /></option>
		<option value="Femenino" ${autorInstance?.genero == 'Femenino' ? 'selected="selected"':''}><g:message code="autores.estado.femenido" default="femenido" /></option>
	</select>
</div>

<div class="col-3 col-12-xsmall fieldcontain ${hasErrors(bean: autorInstance, field: 'difunto', 'error')} required">
	<label for="difunto" class="text-right">
		<g:message code="autor.difunto.label" default="Difunto"/>
		<span class="required-indicator">*</span>
	</label>
	<select name="difunto" id="difunto">
		<option value="false" ${autorInstance?.difunto == false ? 'selected="selected"':''}><g:message code="autores.estado.vivo" default="vivo" /></option>
		<option value="true" ${autorInstance?.difunto == true ? 'selected="selected"':''}><g:message code="autores.estado.muerto" default="muerto" /></option>
	</select>
</div>

<div class="col-3 col-12-xsmall fieldcontain ${hasErrors(bean: autorInstance, field: 'nacionalidad', 'error')} required">
	<label for="nacionalidad" class="text-right">
		<g:message code="autor.nacionalidad.label" default="Nacionalidad"/>
		<span class="required-indicator">*</span>
	</label>
	<g:countrySelect name="nacionalidad" value="${autorInstance.nacionalidad}" noSelection="['':'Escoge la nacionalidad del Autor']" required="" class="tamanoInput"/>
</div>

%{-- Imagen --}%
<div class="col-12 fieldcontain ${hasErrors(bean: autorInstance, field: 'imagen', 'error')}">
	<label for="imagen" class="text-right">
		<g:message code="autor.imagen.label" default="Ruta Imagen"/>:
	</label>
	<g:if test="${!autorInstance?.rutaImagen}">
		<div class="box">
			<g:field type="file" name="imagen" id="imgAutor" accept="image/*" class="tamanoInput"/>
			<div class="imgAutorInfo small">
				<span>
					<g:message code="autores.imagen.formatos"/>
				</span>
			</div>
		</div>
	</g:if>
	<g:else>
		<g:hiddenField name="checkImg" value="${true}"/>
		<g:checkBox name="CheckboxImg" />
		<label for="CheckboxImg">
			<g:message code="autores.imagen.checBoxDelete"/>
		</label>
	</g:else>
</div>