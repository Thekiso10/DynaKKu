<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain"/>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mangas.css')}" type="text/css">
		<g:set var="entityName" value="${message(code: 'layoutMenu.botonesColeccion.manga', default: 'Mangas')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>

        <section>
            <g:form url="[resource:mangasInstance, action:'save']" id="formCreateMagas" enctype='multipart/form-data'>
                <header class="main">
                    <h1>
                        <g:message code="default.create.label" args="[entityName]" />
                    </h1>
                </header>

                <g:if test="${flash.message}">
                    <div class="flash mensajes iconoMensajes" role="status">${flash.message}</div>
                </g:if>

                <g:if test="${flash.error}">
                    <div class="flash errors iconoError" role="status">${flash.error}</div>
                </g:if>

                <g:hasErrors bean="${mangasInstance}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${mangasInstance}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>

                <fieldset class="form">
                    <div class="row gtr-uniform">
                        <g:render template="templates/form"/>
                    </div>
                </fieldset>

                <fieldset class="buttonForms">
                    <div>
                        <g:if test="${hayAutores}">
                            <g:submitButton name="create" class="button fit" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                        </g:if>
                        <g:else>
                            <g:submitButton name="create" class="button fit" value="${message(code: 'default.button.create.label', default: 'Create')}" disabled="disabled"/>
                        </g:else>
                    </div>
                </fieldset>

            </g:form>
        </section>

    <g:javascript src="Mangas.js"/>
	</body>
</html>
