<%@ page import="Modulos.Gestor_Modulos.GestorModulos"%>

<nav id="menu" class="">
    <!-- Menu -->
    <header class="major">
        <h2>
            <g:message code="layoutMenu.menu.label"/>
        </h2>
    </header>

    <ul>
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
            </ul>
        </li>

        <li>
            <span class="opener"><g:message code="layoutMenu.botonesColeccion.autores"/></span>
            <ul>
                <li>
                    <g:link action="create" controller="Autor"><g:message code="layoutMenu.botonesColeccion.autores.crear"/></g:link>
                </li>
                <li>
                    <g:link action="index" controller="Autor"><g:message code="layoutMenu.botonesColeccion.autores.lista"/></g:link>
                </li>
            </ul>
        </li>

        <li>
            <span class="opener"><g:message code="layoutMenu.botonesColeccion.funciones"/></span>
            <ul>
                <sec:ifAnyGranted roles="ROLE_ADMIN">
                    <li><g:link action="panel" controller="gestorModulos"><g:message code="modulos.gestorModulos.title"/></g:link></li>
                </sec:ifAnyGranted>

                <g:if test="${GestorModulos.findByConfigModulo("dynaKKu.estadisticas.enable").valorModulo}">
                    <li><g:link action="general" controller="Estadisticas"><g:message code="layoutMenu.botonesColeccion.funciones.stats"/></g:link></li>
                </g:if>

                <g:if test="${GestorModulos.findByConfigModulo("dynaKKu.historialActividad.enable").valorModulo}">
                    <li><g:link action="index" controller="historial"><g:message code="layoutMenu.botonesColeccion.funciones.historial"/></g:link></li>
                </g:if>
            </ul>
        </li>


        <li>
            <g:link class="" controller="logout">
                <span class="glyphicon glyphicon-log-out"></span>
            </g:link>
        </li>

        <li>
            <a href="#" class="" id="showMe" data-toggle="modal" data-target="#modalConfiguracion">
                <span class="glyphicon glyphicon-cog"></span>
            </a>
        </li>
    </ul>

</nav>
