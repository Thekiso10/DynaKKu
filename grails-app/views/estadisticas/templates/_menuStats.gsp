<div class="container">
    <ul class="navbar-nav">
        <li>
            <g:link class="btn ${type == 'general' ? 'btnSelect':'btnAccion'}" controller="estadisticas" action="general">
                <g:message code="stats.menu.general.label" />
            </g:link>
        </li>
        <li>
            <g:link class="btn ${type == 'autor' ? 'btnSelect':'btnAccion'}" controller="estadisticas" action="statsAutor">
                <g:message code="stats.menu.statsAutor.label" />
            </g:link>
        </li>
        <li>
            <g:link class="btn ${type == 'manga' ? 'btnSelect':'btnAccion'}" controller="estadisticas" action="statsMangas">
                <g:message code="stats.menu.statsMangs.label" />
            </g:link>
        </li>
    </ul>
    <ul class="navbar-nav navbar-right">
        <li>
            <a href="#" class="btn btnSkip" tabindex="-1" onclick="history.back()">
                <g:message code="default.link.skip.label" default="Skip to content&hellip;"/>
            </a>
        </li>
    </ul>
</div>