<div id="modalImportAutores" class="modal-dialog">
    <g:form controller="transferenciaListado" action="ImportAutor" enctype='multipart/form-data'>
        <div id="modalConfiguracion" class="modal-content">
            %{-- Cabecera --}%
            <div class="modal-header">
                <button id="closePopupUser" type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><g:message code="modulos.exportacionListado.title.panelImport"/></h4>
            </div>
            %{-- Cuerpo --}%
            <div class="modal-body">

                <p><g:message code="modulos.exportacionListado.panelImport.import.parrafos"/></p>
                <div class="body-container col-sm-12">
                    <div class="row">
                        <label for="archivoAutor" class="col-sm-3">
                            <g:message code="modulos.exportacionListado.title.panelImport.input" default="Ruta Imagen"/>:
                        </label>
                        <div class="col-sm-9">
                            <g:field type="file" name="archivoAutor" id="archivoAutor" accept="text/xml" class="tamanoInput"/>
                        </div>
                    </div>
                </div>

            </div>
            %{-- Pie --}%
            <div class="modal-footer">
                <button id="btnSubmitUser" type="submit" class="btn btnCommit"><g:message code="default.button.create.label"/></button>
                <button id="btnBackUser" type="button" class="btn btnSkip" data-dismiss="modal"><g:message code="default.link.skip.label"/></button>
            </div>
        </div>
    </g:form>
</div>