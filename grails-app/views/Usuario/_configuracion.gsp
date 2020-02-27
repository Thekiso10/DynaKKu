<%@ page import="Modulos.Personalizacion_Usuario.Usuario" %>

<sec:ifLoggedIn>

    <g:set var="usuarioInstance" value="${Usuario.findById(sec.loggedInUserInfo(['field': 'id']))}"/>

    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            %{-- Cabecera --}%
            <div class="modal-header">
                <button id="closePopupUser" type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"><g:message code="layoutMenu.configuracion.titulo"/></h4>
            </div>
            %{-- Cuerpo --}%
            <div class="modal-body">

                %{-- Flash message --}%
                <div id="userFlashCorrecto" class="flash mensajes iconoMensajes hidden" role="status">
                    <button id="closerFlashGood" type="button" class="close">&times;</button>
                    <span id="textCorrecto"></span>
                </div>

                <div id="userFlashError" class="flash errors iconoError hidden" role="status">
                    <button id="closerFlashError" type="button" class="close">&times;</button>
                    <span id="textError"></span>
                </div>

                <h5 id="tituloUser" class="title-body"><g:message code="layoutMenu.configuracion.titulo.usuario"/></h5>
                <div class="body-container col-sm-12">
                    <div class="row">
                        <div class="col-sm-2 label-body">
                            <span><g:message code="autor.nombre.label"/>:</span>
                        </div>
                        <g:textField name="inputNombre" class="col-sm-10" value="${usuarioInstance?.nombre}"/>
                    </div>

                    <div class="row">
                        <div class="col-sm-2 label-body">
                            <span><g:message code="autor.apellido.label"/>:</span>
                        </div>
                        <g:textField name="inputApellido" class="col-sm-10" value="${usuarioInstance?.apellido}"/>
                    </div>

                </div>

                <h5 class="title-body"><g:message code="layoutMenu.configuracion.titulo.idioma"/></h5>
                <div id="formIdioma" class="body-container col-sm-12">
                    <div class="row">
                        <div class="col-sm-4 text-right input-idioma">
                            <label><g:message code="grailsLogo.bannerLogo.idiomaLink.espanol"/></label>
                            <g:radio name="idioma" value="es" checked="${(usuarioInstance?.idiomaDefault.equals('es') ? 'true' : '')}"/>
                        </div>
                        <div class="col-sm-4 text-center input-idioma">
                            <label><g:message code="grailsLogo.bannerLogo.idiomaLink.catalan"/></label>
                            <g:radio name="idioma" value="cat" checked="${(usuarioInstance?.idiomaDefault.equals('cat') ? 'true' : '')}"/>
                        </div>
                        <div class="col-sm-4 text-left input-idioma">
                            <label><g:message code="grailsLogo.bannerLogo.idiomaLink.ingles"/></label>
                            <g:radio name="idioma" value="en" checked="${(usuarioInstance?.idiomaDefault.equals('en') ? 'true' : '')}"/>
                        </div>
                    </div>
                </div>

                <h5 class="title-body"><g:message code="layoutMenu.configuracion.titulo.mode"/></h5>
                <div id="formMode" class="body-container col-sm-12">
                    <div class="row">
                        <div class="col-sm-6 text-right input-idioma">
                            <label><g:message code="layoutMenu.configuracion.modeDark"/></label>
                            <g:radio name="mode" value="true" checked="${(usuarioInstance?.modoDark ? 'true' : '')}"/>
                        </div>
                        <div class="col-sm-6 text-left input-idioma">
                            <label><g:message code="layoutMenu.configuracion.modeLight"/></label>
                            <g:radio name="mode" value="false" checked="${(!usuarioInstance?.modoDark ? 'true' : '')}"/>
                        </div>
                    </div>
                </div>

            </div>
            %{-- Pie --}%
            <div class="modal-footer">
                <button id="btnSubmitUser" type="button" class="btn btnCommit"><g:message code="default.button.create.label"/></button>
                <button id="btnBackUser" type="button" class="btn btnSkip" data-dismiss="modal"><g:message code="default.link.skip.label"/></button>
            </div>
        </div>

    </div>
</sec:ifLoggedIn>

%{-- Llamada a Ajax --}%

<script>

    $('#closerFlashGood').click(function() {
        $("#userFlashCorrecto").addClass('hidden');
    });

    $('#closerFlashError').click(function() {
        $("#userFlashError").addClass('hidden');
    });

    $('#btnBackUser').click(function() {
        resetFlashMessage();
    });

    $('#closePopupUser').click(function() {
        resetFlashMessage();
    });

    $('#btnSubmitUser').click(function() {
        //Obtenemos el nombre seleccionado
        var nombre = $('#inputNombre').val();
        //Obtenemos el apellido seleccionado
        var apellido = $('#inputApellido').val();
        //Obtenemos el idioma seleccionado
        var idioma = $('input[name=idioma]:checked', '#formIdioma').val();
        //Obtenemos el modo seleccionado
        var mode = $('input[name=mode]:checked', '#formMode').val();

        updateUser(nombre,apellido,idioma,mode);
    });

    function resetFlashMessage() {
        if(!$( "#closerFlashGood" ).hasClass("hidden")){
            $("#userFlashCorrecto").addClass('hidden');
        }

        if(!$( "#closerFlashError" ).hasClass("hidden")){
            $("#userFlashError").addClass('hidden');
        }
    }

    function cargarCambios() {
        if($('link[href="colores/nightMode.css"]')){
            if(${!usuarioInstance.modoDark}){
                location.reload();
            }
        }else{
            if(${usuarioInstance.modoDark}){
                location.reload();
            }
        }
    }

    function updateUser(nombre, apellido, idioma, mode) {
        $.ajax({
            url: '${g.createLink(controller: 'usuario', action: 'updateMe', absolute: true)}',
            type: "post",
            data: {nombre: nombre, apellido: apellido, idioma: idioma, mode: mode},
            success: function(data) {
                var text = null;
                if(data.valido === true){
                    cargarCambios();
                    text = "${g.message(code: 'layoutMenu.configuracion.save.correcto')}";
                    $("#textCorrecto").html(text);
                    $("#userFlashCorrecto").removeClass("hidden");
                    window.location.reload();
                }else{
                    if(data.error === 'code01'){
                        text = "${g.message(code: 'layoutMenu.configuracion.save.error.code01')}";
                    }else if (data.error === 'code02'){
                        text = "${g.message(code: 'layoutMenu.configuracion.save.error.code02')}";
                    }

                    $("#textError").html(text);
                    $("#userFlashError").removeClass("hidden")
                }
            },
            error: function (response) {
                var text = "${g.message(code: 'layoutMenu.configuracion.error')}"
                $("#textError").html(text);
                $("#userFlashError").removeClass("hidden")
            },
            beforeSend: function() {
                callSpinner();
            },
            complete: function() {
                stopSpinner();
            }
        })
    }

</script>