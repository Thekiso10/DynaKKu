<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="layoutMain"/>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'stats.css')}" type="text/css">
        <title><g:message code="stats.header.title.general.label"/></title>
    </head>
    <body>
        <div id="stats-autor" class="col-sm-12" role="main">
            <%-- Barra de Menu de navegacion secundaria --%>
            <div class="menu navbar-collapse" role="navigation">
                <g:render template="/estadisticas/templates/menuStats" model="[type = 'autor']"/>
            </div>
            <%-- Cuerpo de la vista --%>
            <div id="bodyStats" class="container">
                <h2>
                    <g:message code="stats.menu.statsAutor.label"/>
                </h2>

                %{-- Primero Bloque --}%
                <div id="numeroAutoresStats" class="col-sm-12">

                    <h3>
                        <span class="glyphicon glyphicon-asterisk"></span>
                        <g:message code="stats.autores.title.gen" args='${[message(code: 'stats.menu.statsAutor.label')]}'/>
                    </h3>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-10 enumStat">
                            <g:message code="stats.autores.generales.mayorMangas"/>:
                            <span>
                                %{-- Aqui va el resultado de la estadistica --}%
                            </span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-10 enumStat">
                            <g:message code="stats.autores.generales.mas" args='${[message(code: 'stats.code.joven')]}'/>:
                            <span>
                                %{-- Aqui va el resultado de la estadistica --}%
                            </span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-10 enumStat">
                            <g:message code="stats.autores.generales.mas" args='${[message(code: 'stats.code.mayor')]}'/>:
                            <span>
                                %{-- Aqui va el resultado de la estadistica --}%
                            </span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-10 enumStat">
                            <g:message code="stats.autores.generales.registrado"/>:
                            <span>
                                %{-- Aqui va el resultado de la estadistica --}%
                            </span>
                        </div>
                    </div>

                </div>

                %{-- Segundo Bloque --}%
                <div id="numeroAutoresStats" class="col-sm-12">

                    <h3>
                        <span class="glyphicon glyphicon-asterisk"></span>
                        <g:message code="stats.autores.title.por" args='${[message(code: 'stats.menu.statsAutor.label')]}'/>
                    </h3>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-10 enumStat">
                            <g:message code="stats.autores.porcentajes.generico" args='${[message(code: 'autor.genero.label'), message(code: 'autores.estado.masculino')]}'/>:
                            <span>
                                %{-- Aqui va el resultado de la estadistica --}%
                            </span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-10 enumStat">
                            <g:message code="stats.autores.porcentajes.generico" args='${[message(code: 'autor.genero.label'), message(code: 'autores.estado.femenido')]}'/>:
                            <span>
                                %{-- Aqui va el resultado de la estadistica --}%
                            </span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-10 enumStat">
                            <g:message code="stats.autores.porcentajes.vivos"/>:
                            <span>
                                %{-- Aqui va el resultado de la estadistica --}%
                            </span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-10 enumStat">
                            <g:message code="stats.autores.porcentajes.muertos"/>:
                            <span>
                                %{-- Aqui va el resultado de la estadistica --}%
                            </span>
                        </div>
                    </div>

                </div>

                %{-- Tercero Bloque --}%
                <div id="numeroAutoresStats" class="col-sm-12">

                    <h3>
                        <span class="glyphicon glyphicon-asterisk"></span>
                        <g:message code="stats.autores.title.num" args='${[message(code: 'stats.menu.statsAutor.label')]}'/>
                    </h3>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-10 enumStat">
                            <g:message code="stats.autores.numeros.masculino"/>:
                            <span>
                                %{-- Aqui va el resultado de la estadistica --}%
                            </span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-10 enumStat">
                            <g:message code="stats.autores.numeros.femenino"/>:
                            <span>
                                %{-- Aqui va el resultado de la estadistica --}%
                            </span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-10 enumStat">
                            <g:message code="stats.autores.numeros.generico" args='${[message(code: 'autores.estado.vivo')]}'/>:
                            <span>
                                %{-- Aqui va el resultado de la estadistica --}%
                            </span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-10 enumStat">
                            <g:message code="stats.autores.numeros.generico" args='${[message(code: 'autores.estado.muerto')]}'/>:
                            <span>
                                %{-- Aqui va el resultado de la estadistica --}%
                            </span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-10 enumStat">
                            <g:message code="stats.autores.numeros.generico" args='${[message(code: 'autor.registro.label')]}'/>:
                            <span>
                                %{-- Aqui va el resultado de la estadistica --}%
                            </span>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </body>
</html>
