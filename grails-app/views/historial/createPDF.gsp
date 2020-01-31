<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layoutMain" />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'colecciones.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'datePicker/datepicker.css')}" type="text/css">
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

                <fieldset class="form">
                    <div class="panel-form row">
                        <h3>
                            <g:message code="modulos.historial.generate.pdf.params" args=""/>
                        </h3>

                        <div class="col-sm-12 borderBox">
                            <div class="col-sm-6 text-center blockInpunts">
                                <label for="tipoHistorial">
                                    <g:message code="modulos.historial.createPDF.tipoHistorial.label" default="tipo de historial"/>:
                                </label>
                                <select name="tipoHistorial" id="tipoHistorial">
                                    <option value="0"><g:message code="layoutMenu.botonesColeccion.mangas" default="manga" /></option>
                                    <option value="1"><g:message code="layoutMenu.botonesColeccion.autores" default="autor" /></option>
                                    <option value="2"><g:message code="layoutMenu.botonesColeccion.funciones" default="modulos" /></option>
                                </select>
                            </div>

                            <div class="col-sm-6 text-center blockInpunts">
                                <g:select name="function" from="${listaFuncionesMangas}" optionKey="key" optionValue="value"/>
                                <g:select name="function" from="${listaFuncionesAutores}" optionKey="key" optionValue="value" class="hide"/>
                                <g:select name="function" from="${listaFuncionesModulos}" optionKey="key" optionValue="value" class="hide"/>
                            </div>

                        </div>

                        <div class="col-sm-12 borderBox">
                            <div class="col-sm-6 text-center blockInpunts">
%{--                                <table>--}%
%{--                                    <tr>--}%
%{--                                        <td>--}%
%{--                                            <input type="text" id="startDate" name="startDate" class="datepicker form-control" size="10" data-date-format="dd/MM/yy" placeholder="${message(code:'search.start.label')}" value="${params?.startDate}" />--}%
%{--                                        </td>--}%
%{--                                        <td>--}%
%{--                                            <input type="text" id="endDate" name="endDate" class="datepicker form-control" size="10" data-date-format="dd/MM/yy" placeholder="${message(code:'search.end.label')}" value="${params?.endDate}" />--}%
%{--                                        </td>--}%
%{--                                    </tr>--}%
%{--                                </table>--}%
                            </div>

                            <div class="col-sm-6 text-center blockInpunts">

                            </div>

                            <div class="col-sm-6 text-center blockInpunts">

                            </div>

                        </div>

                    </div>
                </fieldset>

                <fieldset class="buttons">
                    <div class="col-sm-12 divButtonSave">
                        <g:submitButton name="generatePDF" class="btn btnSave" value="${message(code: 'default.generate.pdf.label')}"/>
                    </div>
                </fieldset>

            </div>

        </g:form>
    </div>

    <g:javascript src="datePicker/datepickerInterval-yy.js" />

    <g:if test="${RequestContextUtils.getLocale(request) == new Locale('es')}">
        <g:javascript src="datePicker/locales/bootstrap-datepicker.es.js" />
    </g:if>
    <g:elseif test="${RequestContextUtils.getLocale(request) == new Locale('ca','es')}">
        <g:javascript src="datePicker/locales/bootstrap-datepicker.cat.js" />
    </g:elseif>
    <g:else>
        <g:javascript src="datePicker/locales/bootstrap-datepicker.js" />
    </g:else>


</body>
</html>