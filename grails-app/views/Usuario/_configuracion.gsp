<%@ page import="Modulos.Personalizacion_Usuario.Usuario" %>

<sec:ifLoggedIn>

    <g:set var="usuarioInstance" value="${Usuario.findById(sec.loggedInUserInfo(['field': 'id']))}"/>

    <div id="modalDatosUsuario" class="modal-dialog">
        <g:formRemote name="updateMe" url="[controller: 'usuario', action: 'updateMe']" update="[success: 'textCorrecto', failure: 'textError']"
                        onLoading="resetFlashMessage(); callSpinner();" onComplete="stopSpinner();" onSuccess="showFlashMessage(); stopSpinner();" onFailure="showFlashError(); stopSpinner();">
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
                            <div class="col-sm-6">
                                <div class="col-sm-5 label-body">
                                    <span><g:message code="layoutMenu.configuracion.username"/>:</span>
                                </div>
                                <g:textField name="username" class="col-sm-7" required="" value="${usuarioInstance?.username}"/>
                            </div>

                            <div class="col-sm-6">
                                <div class="col-sm-5 label-body">
                                    <span><g:message code="layoutMenu.configuracion.mail"/>:</span>
                                </div>
                                <g:field type="email" name="email" class="col-sm-7" required="" value="${usuarioInstance?.mail}"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="col-sm-5 label-body">
                                    <span><g:message code="autor.nombre.label"/>:</span>
                                </div>
                                <g:textField name="nombre" class="col-sm-7" required="" value="${usuarioInstance?.nombre}"/>
                            </div>

                            <div class="col-sm-6">
                                <div class="col-sm-5 label-body">
                                    <span><g:message code="autor.apellido.label"/>:</span>
                                </div>
                                <g:textField name="apellido" class="col-sm-7" required="" value="${usuarioInstance?.apellido}"/>
                            </div>
                        </div>
                    </div>

                    <div id="changePassword" class="body-container col-sm-12 hidden">
                        <g:hiddenField name="changePasswordParam" value="false"/>

                        <div class="row">
                            <div class="col-sm-4 label-body">
                                <span><g:message code="layoutMenu.configuracion.password"/>:</span>
                            </div>
                            <g:passwordField id="password" name="password" class="col-sm-7"/>
                        </div>

                        <div class="row">
                            <div class="col-sm-4 label-body">
                                <span><g:message code="layoutMenu.configuracion.repitPass"/>:</span>
                            </div>
                            <g:passwordField id="repitPassword" name="repitPassword" class="col-sm-7"/>
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
                    <button id="btnSubmitUser" type="submit" class="btn btnCommit"><g:message code="default.button.create.label"/></button>
                    <button id="btnChangePass" type="button" class="btn btnCommit"><g:message code="layoutMenu.configuracion.changePass"/></button>
                    <button id="btnBackUser" type="button" class="btn btnSkip" data-dismiss="modal"><g:message code="default.link.skip.label"/></button>
                </div>
            </div>

            <g:hiddenField name="id" value="${usuarioInstance.id}"/>

        </g:formRemote>
    </div>
</sec:ifLoggedIn>

<g:javascript src="Usuarios.js"/>

<script>
    function showFlashMessage() {
        $("#userFlashCorrecto").removeClass('hidden');
        /* Hacer que se actualize los CSS */
        var modoOscuro = $('input[name=mode]:checked', '#formMode').val();
        if($('link[href="/DynaKKu/css/colores/nightMode.css"]').length > 0){
            if(modoOscuro == 'false'){
                $('link[href="/DynaKKu/css/colores/nightMode.css"]').attr('href', '/DynaKKu/css/colores/lightMode.css');
            }
        }else{
            if(modoOscuro == 'true'){
                $('link[href="/DynaKKu/css/colores/lightMode.css"]').attr('href', '/DynaKKu/css/colores/nightMode.css');
            }
        }
    }

    function showFlashError() {
        $("#userFlashError").removeClass('hidden');
    }
</script>