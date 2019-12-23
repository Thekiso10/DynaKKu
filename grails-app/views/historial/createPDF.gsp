<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layoutMain" />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'colecciones.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'Modulos/Historial/historial.css')}" type="text/css">
    <g:set var="entityName" value="${message(code: 'modulos.historial.lable', default: 'historial')}" />
    <title><g:message code="default.list.generatePDF.label" args="[entityName]"/></title>
</head>
<body>
    <div id="Generate-Historial-PDF" class="col-sm-12" role="main">
        <g:form url="[action:'generateHistorialPDF']" enctype='multipart/form-data' id="formGenerateHistorialPDF" class="form-principal">
            %{-- Panel de navegación --}%
            <div class="menu navbar-collapse" role="navigation">
                <div class="container">
                    <ul class="navbar-nav">
                        <li>
                            <g:submitButton name="generatePDF" class="btn btnSave" value="${message(code: 'default.generate.pdf.label')}"/>
                        </li>
                        <li>
                            <g:link class="btn btnLlist" controller="historial" action="index">
                                <g:message code="modulos.historial.actividad.lable"/>
                            </g:link>
                        </li>
                    </ul>
                    <ul class="navbar-nav navbar-right">
                        <li>
                            <a href="#" class="btn btnSkip" tabindex="-1" onclick="history.back()">
                                <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="container">

                <h2>
                    <g:message code="modulos.historial.generate.pdf.title" args="[entityName]" />
                </h2>

                <g:if test="${flash.message}">
                    <div class="flash mensajes iconoMensajes" role="status">${flash.message}</div>
                </g:if>

                <g:if test="${flash.error}">
                    <div class="flash errors iconoError" role="status">${flash.error}</div>
                </g:if>



            </div>

        </g:form>
    </div>
</body>
</html>