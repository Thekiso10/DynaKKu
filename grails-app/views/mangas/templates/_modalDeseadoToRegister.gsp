<div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
        <g:form action="updateStateMangas" name="formUpdateStateMangas" id="${mangasInstance?.id}" params="[show: 'true']">
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