<%@ page import="Modulos.Gestor_Modulos.GestorModulos"%>

<nav id="layout-menu" class="col-sm-12">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-main-colleciones" aria-expanded="false">
                <span class="glyphicon glyphicon-chevron-down"/>
                <span class="sr-only">Toggle navigation</span>
            </button>
        </div>

        <div class="collapse navbar-collapse" id="navbar-main-colleciones">
            <ul class="nav navbar-nav" id="BotonesColeccion">
                <li class="dropdown">
                    <a href="#" class="btn btnExtra" onclick="modificarIconoMenu(this)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        <span class="glyphicon glyphicon-chevron-down"></span><g:message code="layoutMenu.botonesColeccion.mangas"/></a>
                    <ul class="dropdown-menu styleDropdown">
                        <li><g:link class="btn btnMenu" controller="mangas" action="create"><g:message code="layoutMenu.botonesColeccion.mangas.crear"/></g:link></li>
                        <li><g:link class="btn btnMenu" controller="mangas" action="index" params="[registrado: true]"><g:message code="layoutMenu.botonesColeccion.mangas.lista"/></g:link></li>
                        <li><g:link class="btn btnMenu" controller="mangas" action="index" params="[registrado: false]"><g:message code="layoutMenu.botonesColeccion.mangas.listaDeseados"/></g:link></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="btn btnExtra" onclick="modificarIconoMenu(this)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        <span class="glyphicon glyphicon-chevron-down"></span><g:message code="layoutMenu.botonesColeccion.autores"/></a>
                    <ul class="dropdown-menu styleDropdown">
                        <li><g:link class="btn btnMenu" action="create" controller="Autor"><g:message code="layoutMenu.botonesColeccion.autores.crear"/></g:link></li>
                        <li><g:link class="btn btnMenu" action="index" controller="Autor"><g:message code="layoutMenu.botonesColeccion.autores.lista"/></g:link></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="btn btnExtra" onclick="modificarIconoMenu(this)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        <span class="glyphicon glyphicon-chevron-down"></span><g:message code="layoutMenu.botonesColeccion.funciones"/></a>
                    <ul class="dropdown-menu styleDropdown">
                        <sec:ifAnyGranted roles="ROLE_ADMIN">
                            <li><g:link class="btn btnMenu" action="panel" controller="gestorModulos"><g:message code="modulos.gestorModulos.title"/></g:link></li>
                        </sec:ifAnyGranted>

                        <g:if test="${GestorModulos.findByConfigModulo("dynaKKu.estadisticas.enable").valorModulo}">
                            <li><g:link class="btn btnMenu" action="general" controller="Estadisticas"><g:message code="layoutMenu.botonesColeccion.funciones.stats"/></g:link></li>
                        </g:if>

                        <g:if test="${GestorModulos.findByConfigModulo("dynaKKu.historialActividad.enable").valorModulo}">
                            <li><g:link class="btn btnMenu" action="index" controller="historial"><g:message code="layoutMenu.botonesColeccion.funciones.historial"/></g:link></li>
                        </g:if>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right" id="BotonesExtra">
                <li>
                    <g:link class="btn btnExtra"><g:message code="layoutMenu.BotonesExtra.tablas"/></g:link>
                </li>
                <li>
                    <g:link class="btn btnExtra"><g:message code="layoutMenu.BotonesExtra.graficas"/></g:link>
                </li>
                <li>
                    <g:link class="btn btnOpcions" controller="logout">
                        <span class="glyphicon glyphicon-log-out"></span>
                    </g:link>
                </li>
                <li>
                    <a href="#" class="btn btnOpcions" id="showMe" data-toggle="modal" data-target="#modalConfiguracion">
                        <span class="glyphicon glyphicon-cog"></span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>