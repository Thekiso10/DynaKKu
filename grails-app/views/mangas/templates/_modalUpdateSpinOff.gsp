<div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
        <g:form action="updateStateSpinOff" name="formUpdateStateSpinOff" id="${mangasInstance?.id}">
        %{-- Cabecera --}%
            <div class="modal-header">
                <button id="closePopupUser" type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><g:message code="layoutMenu.configuracion.titulo"/></h4>
            </div>
        %{-- Cuerpo --}%
            <div class="modal-body">
                <div id="bodyTextDeseadoToRegister">
                    <p>
                        <g:message code="mangas.modal.updateStateSpinOff.body.text"/>
                    </p>
                </div>

                <div class="separator"></div>

                <div class="row">
                    <div class="col-sm-12 verticalAlign">
                        <g:if test="${!mangasInstance?.mangaSpinOff}">
                            <label for="spinOff" class="col-sm-3">
                                <g:message code="layoutMenu.botonesColeccion.mangas.lista" default="Num Tomos Actuales" />:
                            </label>
                            <g:select class="col-sm-8" name="spinOff" from="${Colecciones.Mangas.findAllByBorradoAndIdNotEqual(false, mangasInstance.id)}" optionValue="nombreManga" value="${params.mangaSpinOff?.nombreManga}" optionKey="id" noSelection="[null:'']"/>
                        </g:if>
                        <g:else>
                            <label for="spinOff" class="col-sm-2">
                                <g:message code="mangas.spinOff.label" default="Num Tomos Actuales" />:
                            </label>
                            <span>${mangasInstance?.mangaSpinOff?.nombreManga}</span>
                        </g:else>
                    </div>
                </div>

            </div>
        %{-- Pie --}%
            <div class="modal-footer" id="modalSummit">
                <button type="submit" class="btn ${!mangasInstance?.mangaSpinOff ? 'btnCommit' : 'btnDelete'}">
                    <g:if test="${!mangasInstance?.mangaSpinOff}">
                        <g:message code="default.button.create.label"/>
                    </g:if>
                    <g:else>
                        <g:message code="mangas.show.spinOff.delete"/>
                    </g:else>
                </button>

                <button id="btnBackUser" type="button" class="btn btnSkip" data-dismiss="modal">
                    <g:message code="default.link.skip.label"/>
                </button>
            </div>
        </g:form>
    </div>
</div>