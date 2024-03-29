<%@ page import="Modulos.Gestor_Modulos.GestorModulos"%>
<%@ page import="dynaKKu.AutorService" %>
<%@ page import="dynaKKu.MangasService" %>

<%
    def autorService = grailsApplication.classLoader.loadClass('dynaKKu.AutorService').newInstance()
    def mangasService = grailsApplication.classLoader.loadClass('dynaKKu.MangasService').newInstance()
%>

<nav id="menu" class="">
    <!-- Menu -->
    <header class="major">
        <h2>
            <g:message code="layoutMenu.menu.label"/>
        </h2>
    </header>

    <ul>
        %{-- Mangas --}%
        <li>
            <span class="opener"><g:message code="layoutMenu.botonesColeccion.mangas"/></span>
            <ul>
                <li>
                    <g:link controller="mangas" action="create"><g:message code="layoutMenu.botonesColeccion.mangas.crear"/></g:link>
                </li>

                <li>
                    <g:link controller="mangas" action="index" params="[registrado: true]"><g:message code="layoutMenu.botonesColeccion.mangas.lista"/></g:link>
                </li>

                <li>
                    <g:link controller="mangas" action="index" params="[registrado: false]"><g:message code="layoutMenu.botonesColeccion.mangas.listaDeseados"/></g:link>
                </li>

                <g:if test="${GestorModulos.findByConfigModulo("dynaKKu.exportacionListado.enable").valorModulo}">
                    <g:if test="${mangasService.getSizeMangasWithBorrados() > 0}">
                        <li>
                            <g:link controller="transferenciaListado" action="ExportarCollectionPdf" params="[collection: 'mangas']">
                                <g:message code="default.list.generatePDF.label" args='["${message(code: 'layoutMenu.botonesColeccion.mangas', default: 'mangas')}"]' />
                            </g:link>
                        </li>

                        <li>
                            <g:link controller="transferenciaListado" action="ExportMangas">
                                <g:message code="modulos.exportacionListado.export.label" args="${[message(code: 'layoutMenu.botonesColeccion.mangas')]}"/>
                            </g:link>
                        </li>
                    </g:if>

                    <li>
                        <a href="#" data-toggle="modal" data-target="#ImportMangasModal">
                            <g:message code="modulos.exportacionListado.import.label" args="${[message(code: 'layoutMenu.botonesColeccion.mangas')]}"/>
                        </a>
                    </li>
                </g:if>

            </ul>
        </li>

        %{-- Autores --}%
        <li>
            <span class="opener"><g:message code="layoutMenu.botonesColeccion.autores"/></span>
            <ul>
                <li>
                    <g:link action="create" controller="Autor"><g:message code="layoutMenu.botonesColeccion.autores.crear"/></g:link>
                </li>
                <li>
                    <g:link action="index" controller="Autor"><g:message code="layoutMenu.botonesColeccion.autores.lista"/></g:link>
                </li>

                <g:if test="${GestorModulos.findByConfigModulo("dynaKKu.exportacionListado.enable").valorModulo}">
                    <g:if test="${autorService.getSizeAutorWithBorrados() > 0}">
                        <li>
                            <g:link controller="transferenciaListado" action="ExportarCollectionPdf" params="[collection: 'autores']">
                                <g:message code="default.list.generatePDF.label" args='["${message(code: 'layoutMenu.botonesColeccion.autores', default: 'autor')}"]' />
                            </g:link>
                        </li>

                        <li>
                            <g:link controller="transferenciaListado" action="ExportAutores">
                                <g:message code="modulos.exportacionListado.export.label" args="${[message(code: 'layoutMenu.botonesColeccion.autores')]}"/>
                            </g:link>
                        </li>
                    </g:if>

                    <li>
                        <a href="#" data-toggle="modal" data-target="#ImportAutoresModal">
                            <g:message code="modulos.exportacionListado.import.label" args="${[message(code: 'layoutMenu.botonesColeccion.autores')]}"/>
                        </a>
                    </li>
                </g:if>

            </ul>
        </li>

        %{-- Estadisticas --}%
        <g:if test="${GestorModulos.findByConfigModulo("dynaKKu.estadisticas.enable").valorModulo}">
            <li>
                <g:link action="general" controller="Estadisticas">
                    <g:message code="layoutMenu.botonesColeccion.funciones.stats"/>
                </g:link>
            </li>
        </g:if>

        %{-- Modulos --}%
        <li>
            <span class="opener"><g:message code="layoutMenu.botonesColeccion.funciones"/></span>
            <ul>
                <sec:ifAnyGranted roles="ROLE_ADMIN">
                    <li><g:link action="panel" controller="gestorModulos"><g:message code="modulos.gestorModulos.title"/></g:link></li>
                </sec:ifAnyGranted>

                <g:if test="${GestorModulos.findByConfigModulo("dynaKKu.historialActividad.enable").valorModulo}">
                    <li><g:link action="index" controller="historial"><g:message code="layoutMenu.botonesColeccion.funciones.historial"/></g:link></li>
                </g:if>
            </ul>
        </li>
    </ul>

    <!-- Usuario -->
    <header class="major padding-top-3">
        <h2>
            <g:message code="layoutMenu.menu.user.label"/>
        </h2>
    </header>

    <ul>
        <li>
            <g:link controller="usuario" action="index">
                <g:message code="modulos.usuarios.portada.title"/>
            </g:link>
        </li>

        <li>
            <a href="#" data-toggle="modal" data-target="#modalConfiguracion">
                <g:message code="layoutMenu.configuracion.titulo.usuario"/>
            </a>
        </li>

        <li>
            <g:link controller="logout">
                <g:message code="layoutMenu.menu.user.signOut.label"/>
            </g:link>
        </li>
    </ul>

</nav>