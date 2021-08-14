<table>
    <thead>
        <tr>

            <g:sortableColumn property="nombreManga" scope="col"
                              title="${message(code: 'mangas.nombreManga.label', default: 'Nombre Manga')}" params="[registrado: mangasRegistrados]"/>

            <g:sortableColumn property="autor" scope="col"
                              title="${message(code: 'layoutMenu.botonesColeccion.autor')}" params="[registrado: mangasRegistrados]"/>

            <g:sortableColumn property="numTomosActuales" scope="col"
                              title="${message(code: 'mangas.numTomosActuales.label')}" params="[registrado: mangasRegistrados]"/>

            <g:sortableColumn property="completado" scope="col"
                              title="${message(code: 'mangas.completado.label', default: 'Completado')}" params="[registrado: mangasRegistrados]"/>

            <g:sortableColumn property="mangaSpinOff" scope="col"
                              title="${message(code: 'mangas.spinOff.label')}" params="[registrado: mangasRegistrados]"/>

            <g:sortableColumn property="demografia" scope="col"
                              title="${message(code: 'mangas.demografia.label')}" params="[registrado: mangasRegistrados]"/>

        </tr>
    </thead>
    <tbody>
    <g:each in="${mangasInstanceList}" status="i" var="mangasInstance">
        <tr>

            <td>
                <g:link action="show" id="${mangasInstance.id}">${fieldValue(bean: mangasInstance, field: "nombreManga")}</g:link>
            </td>

            <td>
                <g:link controller="autor" action="show" id="${mangasInstance.autor?.id}">${mangasInstance.autor.toString()}</g:link>
            </td>

            <td>
                <g:formatNumber number="${mangasInstance.numTomosActuales}" type="number" minIntegerDigits ="2" />
            </td>

            <td>
                <p class="glyphicon ${mangasInstance?.completado ? 'glyphicon-ok' : 'glyphicon-remove'}"></p>
            </td>

            <td>
                <p class="glyphicon ${mangasInstance?.mangaSpinOff ? 'glyphicon-ok' : 'glyphicon-remove'}"></p>
            </td>

            <td>
                <span>${mangasInstance.demografia?.nombre}</span>
            </td>

        </tr>
    </g:each>
    </tbody>
</table>