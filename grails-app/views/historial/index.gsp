<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layoutMain" />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'colecciones.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'Modulos/Historial/historial.css')}" type="text/css">
    <g:set var="entityName" value="${message(code: 'modulos.historial.lable.HISTORIAL_ACTIVIDAD', default: 'historial')}" />
    <title><g:message code="modulos.historial.lable.HISTORIAL_ACTIVIDAD"/></title>
</head>
<body>
    <div id="List-Historial-PDF" class="tablaGenericoa col-sm-12" role="main">

        <div class="menu navbar-collapse" role="navigation">
            <div class="container">
                <ul class="navbar-nav">
                    <li>
                        <g:link class="btn btnLlist" controller="historial" action="createPDF">
                            <g:message code="default.list.generatePDF.del.label" args="[entityName]"/>
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
            <div class="content scaffold-list" role="main">
                <h2>
                    <g:message code="default.list.del.label" args="[entityName]" />
                </h2>

                <div id="tableHistorialList" class="tableDynamic table-responsive ${!listaHistorial? 'borderTransparent':''}">
                    <table class="table table-dark table-striped table-hover ${!listaHistorial? 'hidden':''}">
                        <thead class="thead-dark">
                            <tr>
                                <th><g:message code="modulos.historial.createPDF.tipoHistorial.label"/></th>
                                <th><g:message code="layoutMenu.botonesColeccion.funciones"/></th>
                                <th><g:message code="autor.fechaInscripcion.label"/></th>
                                <th><g:message code="modulos.historial.mensaje.label"/></th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${listaHistorial}" status="i" var="accion">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
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

                <div class="col-sm-12 paginacion menu ${listaHistorialCount <= 20 ? 'hidden':''}">
                    <div class="pagination row">
                        <g:paginate total="${listaHistorialCount ?: 0}" params="${params}" />
                    </div>
                </div>

            </div>
        </div>

    </div>
</body>
</html>