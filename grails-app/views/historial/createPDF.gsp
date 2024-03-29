<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layoutMain" />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'datePicker/datepicker.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'Modulos/Historial/historial.css')}" type="text/css">
    <g:set var="entityName" value="${message(code: 'modulos.historialActividad.title', default: 'historial')}" />
    <title><g:message code="default.list.generatePDF.label" args="[entityName]"/></title>
</head>
<body>
    <section role="main">
        <g:form url="[action:'generateHistorialPDF']" enctype='multipart/form-data' id="formGenerateHistorialPDF" class="form">

            <header class="main">
                <h1>
                    <g:message code="default.list.generatePDF.label" args="[entityName]" />
                </h1>
            </header>

            <g:if test="${flash.message}">
                <div class="flash mensajes iconoMensajes" role="status">${flash.message}</div>
            </g:if>

            <g:if test="${flash.error}">
                <div class="flash errors iconoError" role="status">${flash.error}</div>
            </g:if>

            <fieldset class="form">

                <header class="major">
                    <h3>
                        <g:message code="modulos.historial.generate.pdf.params" args=""/>
                    </h3>
                </header>

                <div class="row gtr-uniform">

                    <div class="col-4 col-12-xsmall">
                        <label for="tipoHistorial">
                            <g:message code="modulos.historial.createPDF.tipoHistorial.label" default="tipo de historial"/>:
                        </label>
                        <select name="tipoHistorial" id="tipoHistorial">
                            <option value="0"><g:message code="layoutMenu.botonesColeccion.mangas" default="manga" /></option>
                            <option value="1"><g:message code="layoutMenu.botonesColeccion.autores" default="autor" /></option>
                            <option value="2"><g:message code="layoutMenu.botonesColeccion.funciones" default="modulos" /></option>
                        </select>
                    </div>

                    <div class="col-4 col-12-xsmall">
                        <label for="tipoHistorial">
                            <g:message code="default.funciones.label" default="tipo de historial"/>:
                        </label>
                        <g:select name="functionMangas" from="${listaFuncionesMangas}" optionKey="key" optionValue="value"/>
                        <g:select name="functionAutores" from="${listaFuncionesAutores}" optionKey="key" optionValue="value" class="hide"/>
                        <g:select name="functionModulos" from="${listaFuncionesModulos}" optionKey="key" optionValue="value" class="hide"/>
                    </div>

                    <div class="col-4 col-12-xsmall">
                        <label for="selectIdiomas">
                            <g:message code="layoutMenu.configuracion.titulo.idioma" default="tipo de historial"/>:
                        </label>
                        <select name="selectIdiomas" id="selectIdiomas">
                            <option value="es">
                                <g:message code="grailsLogo.bannerLogo.idiomaLink.espanol"/>
                            </option>
                            <option value="cat">
                                <g:message code="grailsLogo.bannerLogo.idiomaLink.catalan"/>
                            </option>
                            <option value="en">
                                <g:message code="grailsLogo.bannerLogo.idiomaLink.ingles"/>
                            </option>
                        </select>
                    </div>

                    <div class="col-3 col-12-xsmall">
                        <input type="text" id="startDate" name="startDate" class="datepicker" size="10" data-date-format="dd/MM/yyyy" placeholder="${message(code:'modulos.historial.createPDF.fecha.inicio.label')}"/>
                    </div>

                    <div class="col-3 col-12-xsmall">
                        <input type="text" id="endDate" name="endDate" class="datepicker" size="10" data-date-format="dd/MM/yyyy" placeholder="${message(code:'modulos.historial.createPDF.fecha.final.label')}"/>
                    </div>

                    <div class="col-3 col-12-xsmall checkBox">
                        <g:checkBox name="allFunction" />
                        <label for="allFunction">
                            <g:message code="modulos.historial.createPDF.allFunction.label" default="tipo de historial"/>
                        </label>
                    </div>

                    <div class="col-3 col-12-xsmall checkBox">
                        <g:checkBox name="allHistorial" />
                        <label for="allHistorial">
                            <g:message code="modulos.historial.createPDF.allHistorial.label" default="tipo de historial"/>
                        </label>
                    </div>

                </div>
            </fieldset>

            <fieldset class="buttonForms">
                <g:submitButton name="generatePDF" class="button fit" value="${message(code: 'default.generate.pdf.label')}" formtarget="_blank"/>
            </fieldset>

        </g:form>
    </section>

    <script>
        $( document ).ready(function() {
            $('#tipoHistorial').change( function() {
                $(this).find(":selected").each(function () {
                    //Ocultamos todas las lista
                    $('#functionMangas').addClass('hide');
                    $('#functionAutores').addClass('hide');
                    $('#functionModulos').addClass('hide');
                    //Mostramos el indicado
                    switch ($(this).val()) {
                        case '0':
                            console.log("a");
                            $('#functionMangas').removeClass('hide');
                            break;
                         case '1':
                             console.log("b");
                             $('#functionAutores').removeClass('hide');
                             break;
                         case '2':
                             console.log("c");
                             $('#functionModulos').removeClass('hide');
                             break;
                        default:
                    }

                });
            });
        });
    </script>

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