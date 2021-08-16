<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
      <meta name="layout" content="layoutMain"/>
      <link rel="stylesheet" href="${resource(dir: 'css', file: 'Modulos/GestorModulos/panel.css')}" type="text/css">
      <title><g:message code="modulos.gestorModulos.title"/></title>
  </head>

  <body>

    <section id="panel-general" role="main">

        <header class="main">
            <h2>
                <g:message code="modulos.gestorModulos.title"/>
            </h2>
        </header>

        <g:if test="${flash.message}">
            <div class="flash mensajes iconoMensajes" role="status">
                ${flash.message}
            </div>
        </g:if>

    <%-- Tabla --%>
        <div id="tableModulesList" class="table-wrapper ${!listModules? 'hidden':''}">
            <table>
                <thead>
                    <tr>
                        <th>
                            <p><g:message code="modulos.gestorModulos.table.modulo.name"/></p>
                        </th>
                        <th>
                            <p><g:message code="modulos.gestorModulos.table.modulo.state"/></p>
                        </th>
                        <%-- Este Th es solo para estetica --%>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${listModules}" status="i" var="module">
                        <tr>

                            <td>
                                <p>${message(code: module?.nombreModulo, default: 'Nombre modulo')}</p>
                            </td>

                            <td>
                                <p>
                                    ${message(code: (module.valorModulo ? "default.habilitado.label" : "default.deshabilitado.label"))}
                                </p>
                            </td>

                            <td>
                                <g:link class="button small" controller="gestorModulos" action="updateValue" id="${module.id}">
                                    ${message(code: (module.valorModulo ? "default.deshabilitado.label" : "default.habilitado.label"))}
                                </g:link>
                            </td>

                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
    </section>

  </body>
</html>