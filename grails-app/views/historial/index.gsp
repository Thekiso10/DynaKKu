<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layoutMain" />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'Modulos/Historial/historial.css')}" type="text/css">
    <g:set var="entityName" value="${message(code: 'modulos.historial.label.HISTORIAL_ACTIVIDAD', default: 'historial')}" />
    <title><g:message code="modulos.historial.label.HISTORIAL_ACTIVIDAD"/></title>
</head>
<body>
    <section id="List-Historial-PDF" role="main">

        <nav class="navbar navbar-default">
            <div class="container-fluid">

                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-historial" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="navbar-historial">
                    <ul class="nav navbar-nav">
                        <li>
                            <div>
                                <g:link class="button" controller="historial" action="createPDF">
                                    <g:message code="default.list.generatePDF.del.label" args="[entityName]"/>
                                </g:link>
                            </div>
                        </li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                         <li>
                            <a href="#" class="button primary" tabindex="-1" onclick="history.back()">
                                <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <header class="main">
            <h1>
                <g:message code="default.list.del.label" args="[entityName]" />
            </h1>
        </header>

        <div id="tableHistorialList" class="table-wrapper ${!listaHistorial? 'hidden':''}">
            <table>
                <thead>
                    <tr>
                        <th><p><g:message code="modulos.historial.createPDF.tipoHistorial.label"/></p></th>
                        <th><p><g:message code="layoutMenu.botonesColeccion.funciones"/></p></th>
                        <th><p><g:message code="autor.fechaInscripcion.label"/></p></th>
                        <th><p><g:message code="modulos.historial.mensaje.label"/></p></th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${listaHistorial}" status="i" var="accion">
                        <tr>
                            <td>${accion.type}</td>
                            <td>${accion.accion}</td>
                            <td><g:formatDate format="dd/MM/yyyy" date="${accion.date}"/> </td>
                            <td>${accion.message}</td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>

        <g:if test="${flash.warn}">
            <div class="flash warn iconoWarning media" role="status">
                ${flash.warn}
            </div>
        </g:if>

        <div class="col-sm-12 text-center ${listaHistorialCount <= 20 ? 'hidden':''}">
            <div class="pagination">
                <g:paginate total="${listaHistorialCount ?: 0}" params="${params}" />
            </div>
        </div>

    </section>
</body>
</html>