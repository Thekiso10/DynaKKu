<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="layoutMain"/>
        <g:set var="entityName" value="${userInstance.toString()}" />
        <title><g:message code="modulos.usuarios.portada.title"/></title>
    </head>

    <body>
        <section id="portada-usuario">
            <g:if test="${flash.message}">
                <div class="flash mensajes iconoMensajes" role="status">${flash.message}</div>
            </g:if>

            <g:if test="${flash.error}">
                <div class="flash errors iconoError" role="status">${flash.error}</div>
            </g:if>

            %{--
                Tiene que contener los siguientes datos:
                    Nombre y apellido del usuario
                    Numeros de tomos en propiedad / Numero de tomoso totales
                    Numeros de colecciones
                    Numeros de colecciones completados
           --}%

            <header class="main">
                <h1>
                    <g:message code="modulos.usuarios.portada.title"/> -
                    ${entityName}
                </h1>
            </header>

            <div>
                %{-- Primer bloque --}%
                <header class="major col-12">
                    <h3><g:message code="stats.menu.statsMangs.basic.label" /></h3>
                </header>

                <article>
                    <fieldset class="form">
                        <div class="row gtr-uniform">
                            <div id="Radial-Bar-Num-Tomos" class="col-4 col-12-xsmall"></div>

                            <div id="Radial-Bar-Mangas-Completos" class="col-4 col-12-xsmall"></div>

                            <div id="Radial-Bar-Mangas-Finalizados" class="col-4 col-12-xsmall"></div>

                        </div>
                    </fieldset>
                </article>

            </div>

            <script>
                $(document).ready(function(){
                    createRadialbarCharts(document.querySelector("#Radial-Bar-Num-Tomos"),${valueTomos.percent}, ${userInstance.modoDark}, "${message(code: "mangas.numTomosActuales.label")}:", 0, 360)
                    createRadialbarCharts(document.querySelector("#Radial-Bar-Mangas-Completos"), ${valueMangasCompleted.percent}, ${userInstance.modoDark}, "${message(code: "mangas.completados.label")}:", 0, 360)
                    createRadialbarCharts(document.querySelector("#Radial-Bar-Mangas-Finalizados"), ${valueMangasConcluded.percent}, ${userInstance.modoDark}, "${message(code: "mangas.serieAcabadas.label")}:", 0, 360)
                });
            </script>

        </section>

        %{-- Import JS --}%
        <g:javascript src="library/apexCharts/apexChartsClass.js"/>
        <g:javascript src="library/apexCharts/charts/radialbar.js"/>
    </body>
</html>