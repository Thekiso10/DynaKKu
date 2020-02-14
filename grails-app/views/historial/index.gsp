<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layoutMain" />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'colecciones.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'Modulos/Historial/historial.css')}" type="text/css">
    <g:set var="entityName" value="${message(code: 'modulos.historial.lable', default: 'historial')}" />
    <title><g:message code="modulos.historial.lable.HISTORIAL_ACTIVIDAD"/></title>
</head>
<body>
    <div id="list-historia" class="col-sm-12" role="main">

        <div class="menu navbar-collapse" role="navigation">
            <div class="container">
                <ul class="navbar-nav">
                    <li>
                        <g:link class="btn btnLlist" controller="historial" action="createPDF">
                            <g:message code="default.list.generatePDF.label" args="[entityName]"/>
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
    </div>
</body>
</html>