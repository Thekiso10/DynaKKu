<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="layoutMain"/>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'Modulos/Estadisticas/stats.css')}" type="text/css">
        <title><g:message code="stats.header.title.general.label"/></title>
    </head>
    <body>
        <div id="stats-mangas" class="col-sm-12" role="main">
            <%-- Barra de Menu de navegacion secundaria --%>
            <div class="menu navbar-collapse" role="navigation">
                <g:render template="/estadisticas/templates/menuStats" model="[type = 'manga']"/>
            </div>
            <%-- Cuerpo de la vista --%>
            <div class="container">

            </div>
        </div>
    </body>
</html>
