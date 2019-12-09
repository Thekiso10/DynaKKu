<table class="table table-dark table-striped table-hover">
    <thead class="thead-dark">
    <tr>

        <g:sortableColumn property="nombreManga" scope="col" title="${message(code: 'mangas.nombreManga.label', default: 'Nombre Manga')}" params="[registrado: mangasRegistrados]"/>

        <g:sortableColumn property="autor" scope="col" title="${message(code: 'layoutMenu.botonesColeccion.autor')}" params="[registrado: mangasRegistrados]"/>

        <g:sortableColumn property="numTomosActuales" scope="col" title="${message(code: 'mangas.numTomosActuales.label')}" params="[registrado: mangasRegistrados]"/>

        <g:sortableColumn property="completado" scope="col" title="${message(code: 'mangas.completado.label', default: 'Completado')}" params="[registrado: mangasRegistrados]"/>

        <g:sortableColumn property="mangaSpinOff" scope="col" title="${message(code: 'mangas.spinOff.label')}" params="[registrado: mangasRegistrados]"/>

        <g:sortableColumn property="demografia" scope="col" title="${message(code: 'mangas.demografia.label')}" params="[registrado: mangasRegistrados]"/>

    </tr>
    </thead>
    <tbody>
    <g:each in="${mangasInstanceList}" status="i" var="mangasInstance">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

            <td><g:link action="show" id="${mangasInstance.id}">${fieldValue(bean: mangasInstance, field: "nombreManga")}</g:link></td>

            <td><g:link controller="autor" action="show" id="${mangasInstance.autor?.id}">${mangasInstance.autor.toString()}</g:link></td>

            <td><g:formatNumber number="${mangasInstance.numTomosActuales}" type="number" minIntegerDigits ="2" /></td>

            <td>
                <g:if test="${mangasInstance?.completado}">
                    <p class="glyphicon glyphicon-ok"></p>
                </g:if>
                <g:else>
                    <p class="glyphicon glyphicon-remove"></p>
                </g:else>
            </td>

            <td>
                <g:if test="${mangasInstance?.mangaSpinOff}">
                    <p class="glyphicon glyphicon-ok"></p>
                </g:if>
                <g:else>
                    <p class="glyphicon glyphicon-remove"></p>
                </g:else>
            </td>

            <td>
                <span>${mangasInstance.demografia?.nombre}</span>
            </td>

        </tr>
    </g:each>
    </tbody>
</table>