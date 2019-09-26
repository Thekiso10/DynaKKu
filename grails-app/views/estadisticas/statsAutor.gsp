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
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.generales.mayorMangas"/>:
                            <span>
                                <g:if test="${numMaxAutorMangas}">

                                </g:if>
                                <g:else>
                                    <span><g:message code="default.stats.noResultados.label"/></span>
                                </g:else>
                            </span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.generales.mas" args='${[message(code: 'stats.code.joven')]}'/>:
                            <g:if test="${edadMin}">
                                <span>[${edadMin} <g:message code="autor.edad.anos.label"/>]</span>
                                <g:each in="${listaValores[0]}" var="autor">
                                    <span>${autor.nombre} ${autor.apellido} |</span>
                                </g:each>
                            </g:if>
                            <g:else>
                                <span><g:message code="default.stats.noResultados.label"/></span>
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
                                <span>[${edadMax} <g:message code="autor.edad.anos.label"/>]</span>
                                <g:each in="${listaValores[1]}" var="autor">
                                    <span>${autor.nombre} ${autor.apellido} |</span>
                                </g:each>
                            </g:if>
                            <g:else>
                                <span><g:message code="default.stats.noResultados.label"/></span>
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
                                <span>[<g:formatDate date="${lastAutor.fechaInscripcion}" format="yyyy-MM-dd HH:mm" />]</span>
                                <span>${lastAutor.nombre} ${lastAutor.apellido}</span>
                            </g:if>
                            <g:else>
                                <span><g:message code="default.stats.noResultados.label"/></span>
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
                            <g:message code="stats.autores.porcentajes.generico" args='${[message(code: 'autor.genero.label'), message(code: 'autores.estado.masculino')]}'/>:
                            <g:if test="${listaPorcetajes[0]}">
                                <span>${listaPorcetajes[0]}</span>
                            </g:if>
                            <g:else>
                                <span><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-1">
                            <g:img class="iconStatsRombo" dir="images/imgWeb/icons/" file="rombo.png"/>
                        </div>
                        <div class="col-sm-11 enumStat">
                            <g:message code="stats.autores.porcentajes.generico" args='${[message(code: 'autor.genero.label'), message(code: 'autores.estado.femenido')]}'/>:
                            <g:if test="${listaPorcetajes[1]}">
                                <span>${listaPorcetajes[1]}</span>
                            </g:if>
                            <g:else>
                                <span><g:message code="default.stats.noResultados.label"/></span>
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
                                <span>${listaPorcetajes[2]}</span>
                            </g:if>
                            <g:else>
                                <span><g:message code="default.stats.noResultados.label"/></span>
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
                                <span>${listaPorcetajes[3]}</span>
                            </g:if>
                            <g:else>
                                <span><g:message code="default.stats.noResultados.label"/></span>
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
                                <span>${listaNumeros[0]}</span>
                            </g:if>
                            <g:else>
                                <span><g:message code="default.stats.noResultados.label"/></span>
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
                                <span>${listaNumeros[1]}</span>
                            </g:if>
                            <g:else>
                                <span><g:message code="default.stats.noResultados.label"/></span>
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
                                <span>${listaNumeros[2]}</span>
                            </g:if>
                            <g:else>
                                <span><g:message code="default.stats.noResultados.label"/></span>
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
                                <span>${listaNumeros[3]}</span>
                            </g:if>
                            <g:else>
                                <span><g:message code="default.stats.noResultados.label"/></span>
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
                                <span>${listaNumeros[4]}</span>
                            </g:if>
                            <g:else>
                                <span><g:message code="default.stats.noResultados.label"/></span>
                            </g:else>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </body>
</html>
