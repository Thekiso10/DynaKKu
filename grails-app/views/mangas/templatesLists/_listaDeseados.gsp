<table class="table table-dark table-striped table-hover" xmlns="">
    <thead class="thead-dark">
    <tr>

        <g:sortableColumn property="nombreManga" scope="col" title="${message(code: 'mangas.nombreManga.label', default: 'Nombre Manga')}" params="[registrado: mangasRegistrados]"/>

        <g:sortableColumn property="autor" scope="col" title="${message(code: 'layoutMenu.botonesColeccion.autor')}" params="[registrado: mangasRegistrados]"/>

        <g:sortableColumn property="mangaSpinOff" scope="col" title="${message(code: 'mangas.spinOff.label')}" params="[registrado: mangasRegistrados]"/>

        <g:sortableColumn property="demografia" scope="col" title="${message(code: 'mangas.demografia.label')}" params="[registrado: mangasRegistrados]"/>

        <th class="limitedColumn"></th>

    </tr>
    </thead>
    <tbody>
    <g:each in="${mangasInstanceList}" status="i" var="mangasInstance">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

            <td><g:link action="show" id="${mangasInstance.id}">${fieldValue(bean: mangasInstance, field: "nombreManga")}</g:link></td>

            <td><g:link controller="autor" action="show" id="${mangasInstance.autor?.id}">${mangasInstance.autor.toString()}</g:link></td>

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

            <td>
                <button id="${mangasInstance.id}" class="btn btnConvert btnMenu" data-toggle="modal" data-target="#modalPassDeseadoToRegister">
                    <g:message code="mangas.list.pass.deseadoToRegister"/>
                </button>
            </td>

        </tr>
    </g:each>
    </tbody>
</table>

<div id="modalPassDeseadoToRegister" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
           <g:form action="updateStateMangas" name="formUpdateStateMangas" params="[registrado: mangasRegistrados]">
               %{-- Cabecera --}%
               <div class="modal-header">
                   <button id="closePopupUser" type="button" class="close" data-dismiss="modal">&times;</button>
                   <h4 class="modal-title"><g:message code="layoutMenu.configuracion.titulo"/></h4>
               </div>
               %{-- Cuerpo --}%
               <div class="modal-body">
                   <div id="bodyTextDeseadoToRegister">
                       <p>
                           <g:message code="mangas.modal.deseadoToRegister.body.text"/>
                       </p>
                   </div>

                   <div class="separator"></div>

                   <div class="row">
                       <div class="col-sm-6 verticalAlign">
                           <label for="numTomosActuales" class="col-sm-7">
                               <g:message code="mangas.numTomosActuales.label" default="Num Tomos Actuales" />:
                           </label>
                           <g:field class="col-sm-5" name="numTomosActuales" type="number" value="1"/>

                       </div>

                       <div class="col-sm-6 verticalAlign">
                           <label for="numTomosMaximos" class="col-sm-8">
                               <g:message code="mangas.numTomosMaximos.label" default="Num Tomos Maximos" />:
                           </label>
                           <g:field class="col-sm-4" name="numTomosMaximos" type="number" value="1"/>

                       </div>
                   </div>

               </div>
               %{-- Pie --}%
               <div class="modal-footer" id="modalSummit">
                   <button type="submit" class="btn btnCommit">
                        <g:message code="default.button.create.label"/>
                   </button>

                   <button id="btnBackUser" type="button" class="btn btnSkip" data-dismiss="modal">
                       <g:message code="default.link.skip.label"/>
                   </button>
               </div>
           </g:form>
        </div>

    </div>
</div>

<script>
    $('.btnConvert').click(function() {
        //Obtener el ID del Manga clicado
        var idManga = $(this).attr('id');
        //Obtenemos el link del popUp y hacemos un split de '?'
        var getLink = $('#formUpdateStateMangas').attr('action');
        getLink = getLink.split('?');
        //Montamos un link nuevo con el ID del Manga
        var href = getLink[0] + '/' + idManga + '?' + getLink[1];
        //Sustituimos el link por el nuevo
        $('#formUpdateStateMangas').attr('action', href);
    });
</script>