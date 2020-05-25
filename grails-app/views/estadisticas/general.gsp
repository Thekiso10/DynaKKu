<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="layoutMain"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'Modulos/Estadisticas/stats.css')}" type="text/css">
    <title><g:message code="stats.header.title.general.label"/></title>
</head>
<body>
<div id="stats-general" class="col-sm-12" role="main">
    <%-- Barra de Menu de navegacion secundaria --%>
    <div class="menu navbar-collapse" role="navigation">
        <g:render template="/estadisticas/templates/menuStats" model="[type = 'general']"/>
    </div>
    <%-- Cuerpo de la vista --%>
    <div id="bodyStats" class="container">
        <h2>
            <g:message code="stats.menu.general.label"/>
        </h2>

        %{-- Primer Bloque --}%
        <div id="consultaColeccionesStats" class="col-sm-12">

            <h3>
                <span class="glyphicon glyphicon-asterisk"></span>
                <g:message code="stats.general.title.colecciones" args='${[message(code: 'stats.menu.general.label')]}'/>
            </h3>

            <div id="consultasAutoresStats" class="marginDiv">
                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.consulta.numero.hoy" args='${[message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.consulta.numero" args='${[message(code: 'stats.code.esta'), message(code: 'stats.code.semana'), message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.consulta.numero" args='${[message(code: 'stats.code.este'), message(code: 'stats.code.mes'), message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.consulta.numero" args='${[message(code: 'stats.code.este'), message(code: 'stats.code.ano'), message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>
            </div>

            <div id="consultasAutoresMediaStats" class="marginDiv">

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.consulta.media" args='${[message(code: 'stats.code.semana'), message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.consulta.media" args='${[message(code: 'stats.code.mes'), message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.consulta.media" args='${[message(code: 'stats.code.ano'), message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>
            </div>

            <div id="consultasMangasStats" class="marginDiv">
                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.consulta.numero.hoy" args='${[message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.consulta.numero" args='${[message(code: 'stats.code.esta'), message(code: 'stats.code.semana'), message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.consulta.numero" args='${[message(code: 'stats.code.este'), message(code: 'stats.code.mes'), message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.consulta.numero" args='${[message(code: 'stats.code.este'), message(code: 'stats.code.ano'), message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>
            </div>

            <div id="consultasMangasMediaStats" class="marginDiv">

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.consulta.media" args='${[message(code: 'stats.code.semana'), message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.consulta.media" args='${[message(code: 'stats.code.mes'), message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.consulta.media" args='${[message(code: 'stats.code.ano'), message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>
            </div>

        </div>

        %{-- Segundo Bloque --}%
        <div id="consultaFuncionesStats" class="col-sm-12">

            <h3>
                <span class="glyphicon glyphicon-asterisk"></span>
                <g:message code="stats.general.title.funciones" args='${[message(code: 'stats.menu.general.label')]}'/>
            </h3>

            <div id="historialMesFuncionStats" class="marginDiv">

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.media.full" args='${[message(code: 'stats.code.historial'), message(code: 'stats.code.mes')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.media" args='${[message(code: 'stats.code.historial'), message(code: 'stats.code.mes'), message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.media" args='${[message(code: 'stats.code.historial'), message(code: 'stats.code.mes'), message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

            </div>

            <div id="historialAnoFuncionStats" class="marginDiv">

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.media.full" args='${[message(code: 'stats.code.historial'), message(code: 'stats.code.ano')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.media" args='${[message(code: 'stats.code.historial'), message(code: 'stats.code.ano'), message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.media" args='${[message(code: 'stats.code.historial'), message(code: 'stats.code.ano'), message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

            </div>

            <div id="reporteMesFuncionStats" class="marginDiv">

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.media.full" args='${[message(code: 'stats.code.reporte'), message(code: 'stats.code.mes')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.media" args='${[message(code: 'stats.code.reporte'), message(code: 'stats.code.mes'), message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.media" args='${[message(code: 'stats.code.reporte'), message(code: 'stats.code.mes'), message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

            </div>

            <div id="reporteAnoFuncionStats" class="marginDiv">

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.media.full" args='${[message(code: 'stats.code.reporte'), message(code: 'stats.code.ano')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.media" args='${[message(code: 'stats.code.reporte'), message(code: 'stats.code.ano'), message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.media" args='${[message(code: 'stats.code.reporte'), message(code: 'stats.code.ano'), message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

            </div>

        </div>


        %{-- Tercero Bloque --}%
        <div id="consultaFuncionesPorStats" class="col-sm-12">

            <h3>
                <span class="glyphicon glyphicon-asterisk"></span>
                <g:message code="stats.general.title.funciones.por" args='${[message(code: 'stats.menu.general.label')]}'/>
            </h3>

            <div id="historialMesFuncionPorStats" class="marginDiv">

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.porcentaje.full" args='${[message(code: 'stats.code.historial'), message(code: 'stats.code.mes')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.porcentaje" args='${[message(code: 'stats.code.historial'), message(code: 'stats.code.mes'), message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.porcentaje" args='${[message(code: 'stats.code.historial'), message(code: 'stats.code.mes'), message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

            </div>

            <div id="historialAnoFuncionPorStats" class="marginDiv">

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.porcentaje.full" args='${[message(code: 'stats.code.historial'), message(code: 'stats.code.ano')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.porcentaje" args='${[message(code: 'stats.code.historial'), message(code: 'stats.code.ano'), message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.porcentaje" args='${[message(code: 'stats.code.historial'), message(code: 'stats.code.ano'), message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

            </div>

            <div id="reporteMesFuncionPorStats" class="marginDiv">

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.porcentaje.full" args='${[message(code: 'stats.code.reporte'), message(code: 'stats.code.mes')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.porcentaje" args='${[message(code: 'stats.code.reporte'), message(code: 'stats.code.mes'), message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.porcentaje" args='${[message(code: 'stats.code.reporte'), message(code: 'stats.code.mes'), message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

            </div>

            <div id="reporteAnoFuncionPorStats" class="marginDiv">

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.porcentaje.full" args='${[message(code: 'stats.code.reporte'), message(code: 'stats.code.ano')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.porcentaje" args='${[message(code: 'stats.code.reporte'), message(code: 'stats.code.ano'), message(code: 'stats.code.autor')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-1 col-xs-2">
                        <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        <span class="glyphicon glyphicon-asterisk hidden-sm stylePoint"></span>
                    </div>
                    <div class="col-sm-11 col-xs-11 enumStat">
                        <g:message code="stats.general.funciones.porcentaje" args='${[message(code: 'stats.code.reporte'), message(code: 'stats.code.ano'), message(code: 'stats.code.manga')]}'/>:
                        <span>
                            %{-- Aqui va el resultado de la estadistica --}%
                        </span>
                    </div>
                </div>

            </div>

        </div>

    </div>
</div>
</body>
</html>
