<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="layoutMain"/>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'Modulos/Estadisticas/stats.css')}" type="text/css">
        <title><g:message code="modulos.estadisticas.title"/></title>
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
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.generales.mayorMangas"/>:
                            <g:if test="${numMaxAutorMangas}">

                            </g:if>
                            <g:else>
                                <span class="dontStats"><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.generales.mas" args='${[message(code: 'stats.code.joven')]}'/>:
                            <g:if test="${edadMin}">
                                <span class="mostrarNum">[${edadMin} <g:message code="autor.edad.anos.label"/>]</span>
                                <g:each in="${listaValores[0]}" var="autor">
                                    <span class="globoDatos"><g:link controller="autor" action="show" params="[id: autor.id]">${autor.nombre} ${autor.apellido}</g:link></span>
                                </g:each>
                            </g:if>
                            <g:else>
                                <span class="dontStats"><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.generales.mas" args='${[message(code: 'stats.code.mayor')]}'/>:
                            <g:if test="${edadMax}">
                                <span class="mostrarNum">[${edadMax} <g:message code="autor.edad.anos.label"/>]</span>
                                <g:each in="${listaValores[1]}" var="autor">
                                    <span class="globoDatos"><g:link controller="autor" action="show" params="[id: autor.id]">${autor.nombre} ${autor.apellido}</g:link></span>
                                </g:each>
                            </g:if>
                            <g:else>
                                <span class="dontStats"><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.generales.registrado"/>:
                            <g:if test="${lastAutor}">
                                <span class="mostrarNum">[<g:formatDate date="${lastAutor.fechaInscripcion}" format="yyyy-MM-dd HH:mm" />]</span>
                                <span class="globoDatos"><g:link controller="autor" action="show" params="[id: lastAutor.id]">${lastAutor.nombre} ${lastAutor.apellido}</g:link></span>
                            </g:if>
                            <g:else>
                                <span class="dontStats"><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
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
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.porcentajes.generico" args='${[message(code: 'autor.genero.label'), message(code: 'autores.estado.MASCULINO')]}'/>:
                            <g:if test="${listaPorcetajes[0]}">
                                <span class="estiloPor">${listaPorcetajes[0]}</span>
                            </g:if>
                            <g:else>
                                <span class="dontStats"><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.porcentajes.generico" args='${[message(code: 'autor.genero.label'), message(code: 'autores.estado.FEMENINO')]}'/>:
                            <g:if test="${listaPorcetajes[1]}">
                                <span class="estiloPor">${listaPorcetajes[1]}</span>
                            </g:if>
                            <g:else>
                                <span class="dontStats"><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.porcentajes.vivos"/>:
                            <g:if test="${listaPorcetajes[2]}">
                                <span class="estiloPor">${listaPorcetajes[2]}</span>
                            </g:if>
                            <g:else>
                                <span class="dontStats"><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.porcentajes.muertos"/>:
                            <g:if test="${listaPorcetajes[3]}">
                                <span class="estiloPor">${listaPorcetajes[3]}</span>
                            </g:if>
                            <g:else>
                                <span class="dontStats"><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
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
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.numeros.masculino"/>:
                            <g:if test="${listaNumeros[0]}">
                                <span class="estiloNum">${listaNumeros[0]} <g:message code="stats.code.enTotal"/></span>
                            </g:if>
                            <g:else>
                                <span class="dontStats"><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.numeros.femenino"/>:
                            <g:if test="${listaNumeros[1]}">
                                <span class="estiloNum">${listaNumeros[1]} <g:message code="stats.code.enTotal"/></span>
                            </g:if>
                            <g:else>
                                <span class="dontStats"><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.numeros.generico" args='${[message(code: 'autores.estado.vivo')]}'/>:
                            <g:if test="${listaNumeros[2]}">
                                <span class="estiloNum">${listaNumeros[2]} <g:message code="stats.code.enTotal"/></span>
                            </g:if>
                            <g:else>
                                <span class="dontStats"><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.numeros.generico" args='${[message(code: 'autores.estado.muerto')]}'/>:
                            <g:if test="${listaNumeros[3]}">
                                <span class="estiloNum">${listaNumeros[3]} <g:message code="stats.code.enTotal"/></span>
                            </g:if>
                            <g:else>
                                <span class="dontStats"><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.numeros.generico" args='${[message(code: 'autor.registro.label')]}'/>:
                            <g:if test="${listaNumeros[4]}">
                                <span class="estiloNum">${listaNumeros[4]} <g:message code="stats.code.enTotal"/></span>
                            </g:if>
                            <g:else>
                                <span class="dontStats"><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </body>
</html>
