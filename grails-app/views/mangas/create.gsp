<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="layoutMain"/>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'colecciones.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mangas.css')}" type="text/css">
		<g:set var="entityName" value="${message(code: 'layoutMenu.botonesColeccion.manga', default: 'Mangas')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="create-mangas" class="col-sm-12" role="main">
            <g:form url="[resource:mangasInstance, action:'save']" id="formCreateMagas" enctype='multipart/form-data'>
                <div class="menu navbar-collapse" role="navigation">
                    <div class="container">
                        <ul class="navbar-nav">
                            <li>
                                <g:if test="${hayAutores}">
                                    <g:submitButton name="createSecundaro" class="btn btnSaveV2" value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                                </g:if>
                                <g:else>
                                    <g:submitButton name="createSecundaro" class="btn btnSaveV2" value="${message(code: 'default.button.create.label', default: 'Create')}" disabled="disabled"/>
                                </g:else>
                            </li>
                        </ul>
                        <ul class="navbar-nav">
                            <li class="dropdown">
                                <a href="#" class="btn btnExtra" onclick="modificarIconoMenu(this)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                    <span class="glyphicon glyphicon-chevron-down"></span>
                                    <g:message code="mangas.list.label" />
                                </a>
                                <ul class="dropdown-menu styleDropdown">
                                    <li>
                                        <g:link class="btn btnMenu ">
                                            <g:message code="mangas.list.registrados.label" />
                                        </g:link>
                                    </li>
                                    <li>
                                        <g:link class="btn btnMenu">
                                            <g:message code="mangas.list.deseados.label" />
                                        </g:link>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                        <ul class="navbar-nav navbar-right">
                            <li><a href="#" class="btn btnSkip" tabindex="-1" onclick="history.back()"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a></li>
                        </ul>
                    </div>
                </div>

                <div class="container">
                    <h2>
                        <g:message code="default.create.label" args="[entityName]" />
                    </h2>

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
                        <g:render template="form"/>
                    </fieldset>
                    <fieldset class="buttons">
                        <div class="col-sm-12 divButtonSave">
                            <g:if test="${hayAutores}">
                                <g:submitButton name="create" class="save btn btnSave" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                            </g:if>
                            <g:else>
                                <g:submitButton name="create" class="save btn btnSave" value="${message(code: 'default.button.create.label', default: 'Create')}" disabled="disabled"/>
                            </g:else>
                        </div>
                    </fieldset>
                </div>
            </g:form>
        </div>
    <g:javascript src="Mangas.js"/>
	</body>
</html>
