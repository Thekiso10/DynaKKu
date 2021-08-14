<div id="modalImportAutores" class="modal-dialog">
    <g:form controller="transferenciaListado" action="ImportAutor" enctype='multipart/form-data'>
        <div class="modal-content">
            %{-- Cabecera --}%
            <div class="modal-header">
                <span id="closePopupUser" class="close" data-dismiss="modal">&times;</span>
                <h4 class="modal-title"><g:message code="modulos.exportacionListado.title.panelImport"/></h4>
            </div>
            %{-- Cuerpo --}%
            <div class="modal-body">

                <p><g:message code="modulos.exportacionListado.panelImport.import.parrafos"/></p>
                <div class="body-container row gtr-uniform">
                    <div class="col-12">
                        <g:message code="modulos.exportacionListado.title.panelImport.input" default="Ruta Imagen"/>:
                        <g:field type="file" name="archivoAutor" id="archivoAutor" accept="text/xml" class="tamanoInput"/>
                    </div>
                </div>

            </div>
            %{-- Pie --}%
            <div class="modal-footer">
                <button id="btnSubmitUser" type="submit" class="button primary small"><g:message code="default.button.create.label"/></button>
            </div>
        </div>
    </g:form>
</div>