<div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
        <g:form action="updateSumTomosManga" name="formUpdateStateMangas" id="${mangasInstance?.id}">
            %{-- Cabecera --}%
            <div class="modal-header">
                <button id="closePopupUser" type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><g:message code="layoutMenu.configuracion.titulo"/></h4>
            </div>
            %{-- Cuerpo --}%
            <div class="modal-body">
                <div id="bodyTextDeseadoToRegister">
                    <p>
                        <g:message code="mangas.modal.sumTomos.body.text"/>
                    </p>
                </div>

                <div class="separator"></div>

                <div class="row">
                    <div class="col-sm-12 verticalAlign">
                        <label for="numTomosActuales" class="col-sm-4">
                            <g:message code="mangas.numTomosActuales.label" default="Num Tomos Actuales" />:
                        </label>
                        <g:field name="numTomosActuales" type="number" value="${mangasInstance?.numTomosActuales}"/>

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