<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
      <meta name="layout" content="layoutMain"/>
      <link rel="stylesheet" href="${resource(dir: 'css', file: 'Modulos/GestorModulos/panel.css')}" type="text/css">
      <title><g:message code="modulos.gestorModulos.title"/></title>
  </head>

  <body>

    <div id="panel-general" class="col-sm-12" role="main">
        <%-- Cuerpo de la vista --%>
        <div id="bodyPanelModule" class="container">
            <div class="content scaffold-list">

                <h2>
                    <g:message code="modulos.gestorModulos.title"/>
                </h2>

                <g:if test="${flash.message}">
                    <div class="flash mensajes iconoMensajes" role="status">
                        ${flash.message}
                    </div>
                </g:if>

                <%-- Tabla --%>
                <div id="tableModulesList" class="tableDynamic table-responsive ${!listModules? 'borderTransparent':''}">
                    <table class="table table-dark table-striped table-hover ${!listModules? 'hidden':''}">
                        <thead class="thead-dark">
                            <tr>
                                <th>Nombre modulo</th>
                                <th>Estado del modulo</th>
                                <%-- Este Th es solo para estetica --%>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${listModules}" status="i" var="module">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                    <td>
                                        <p>${message(code: module?.nombreModulo, default: 'Nombre modulo')}</p>
                                    </td>

                                    <td>
                                        <p>
                                            <g:if test="${module.valorModulo}">
                                                ${message(code: "default.habilitado.label")}
                                            </g:if>
                                            <g:else>
                                                ${message(code: "default.deshabilitado.label")}
                                            </g:else>
                                        </p>
                                    </td>

                                    <td>
                                        <g:link class="btn btnMenu" controller="gestorModulos" action="updateValue" id="${module.id}">
                                            <g:if test="${module.valorModulo}">
                                                ${message(code: "default.deshabilitado.label")}
                                            </g:if>
                                            <g:else>
                                                ${message(code: "default.habilitado.label")}
                                            </g:else>
                                        </g:link>
                                    </td>

                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>

  </body>
</html>