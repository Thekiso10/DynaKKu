<%@ page import="Modulos.Personalizacion_Usuario.Usuario" %>

<g:set var="usuarioInstance" value="${Usuario.findById(sec.loggedInUserInfo(['field': 'id']))}"/>

<div id="modalDatosUsuario" class="modal-dialog form">
    <g:formRemote name="updateMe" url="[controller: 'usuario', action: 'updateMe']" update="[success: 'textCorrecto', failure: 'textError']"
                  onLoading="resetFlashMessage(); callSpinner();" onComplete="stopSpinner();" onSuccess="showFlashMessage(); stopSpinner();" onFailure="showFlashError(); stopSpinner();">
        <!-- Modal content-->
        <div class="modal-content ">
            %{-- Cabecera --}%
            <div class="modal-header">
                <span id="closePopupUser" class="close" data-dismiss="modal">&times;</span>
                <h4 class="modal-title"><g:message code="layoutMenu.configuracion.titulo"/></h4>
            </div>
            %{-- Cuerpo --}%
            <div class="modal-body">
                %{-- Flash message --}%
                <div id="userFlashCorrecto" class="flash mensajes iconoMensajes hidden" role="status">
                    <span id="closerFlashGood" class="close">&times;</span>
                    <span id="textCorrecto"></span>
                </div>

                <div id="userFlashError" class="flash errors iconoError hidden" role="status">
                    <span id="closerFlashError" class="close">&times;</span>
                    <span id="textError"></span>
                </div>

                <h4 id="tituloUser" class="title-body"><g:message code="layoutMenu.configuracion.titulo.usuario"/></h4>
                <div class="body-container row gtr-uniform padding-right-1">
                    <div class="col-6 col-12-xsmall">
                        <span><g:message code="layoutMenu.configuracion.username"/>:</span>
                        <g:textField name="username" required="" value="${usuarioInstance?.username}"/>
                    </div>

                    <div class="col-6 col-12-xsmall">
                        <span><g:message code="layoutMenu.configuracion.mail"/>:</span>
                        <g:field type="email" name="email" required="" value="${usuarioInstance?.mail}"/>
                    </div>

                    <div class="col-6 col-12-xsmall">
                        <span><g:message code="autor.nombre.label"/>:</span>
                        <g:textField name="nombre" required="" value="${usuarioInstance?.nombre}"/>
                    </div>

                    <div class="col-6 col-12-xsmall">
                        <span><g:message code="autor.apellido.label"/>:</span>
                        <g:textField name="apellido" required="" value="${usuarioInstance?.apellido}"/>
                    </div>
                </div>

                <div id="changePassword" class="row gtr-uniform hidden padding-right-1">
                    <g:hiddenField name="changePasswordParam" value="false"/>

                    <div class="col-6 col-12-xsmall">
                        <span><g:message code="layoutMenu.configuracion.password"/>:</span>
                        <g:passwordField id="password" name="password"/>
                    </div>

                    <div class="col-6 col-12-xsmall">
                        <span><g:message code="layoutMenu.configuracion.repitPass"/>:</span>
                        <g:passwordField id="repitPassword" name="repitPassword"/>
                    </div>
                </div>

                <h4 class="title-body"><g:message code="layoutMenu.configuracion.titulo.idioma"/></h4>
                <div id="formIdioma" class="row gtr-uniform">
                    <div class="col-4 col-12-xsmall">
                        <g:radio id="idiomaEs" name="idioma" value="es" checked="${(usuarioInstance?.idiomaDefault.equals('es') ? 'true' : '')}"/>
                        <label for="idiomaEs"><g:message code="grailsLogo.bannerLogo.idiomaLink.espanol"/></label>
                    </div>
                    <div class="col-4 col-12-xsmall">
                        <g:radio id="idiomaCat" name="idioma" value="cat" checked="${(usuarioInstance?.idiomaDefault.equals('cat') ? 'true' : '')}"/>
                        <label for="idiomaCat"><g:message code="grailsLogo.bannerLogo.idiomaLink.catalan"/></label>
                    </div>
                    <div class="col-4 col-12-xsmall">
                        <g:radio id="idiomaEn" name="idioma" value="en" checked="${(usuarioInstance?.idiomaDefault.equals('en') ? 'true' : '')}"/>
                        <label for="idiomaEn"><g:message code="grailsLogo.bannerLogo.idiomaLink.ingles"/></label>
                    </div>
                </div>

                <h4 class="title-body"><g:message code="layoutMenu.configuracion.titulo.mode"/></h4>
                <div id="formMode" class="row gtr-uniform">
                    <div class="col-6 col-12-xsmall">
                        <g:radio id="modeDark" name="mode" value="true" checked="${(usuarioInstance?.modoDark ? 'true' : '')}"/>
                        <label for="modeDark"><g:message code="layoutMenu.configuracion.modeDark"/></label>
                    </div>
                    <div class="col-6 col-12-xsmall">
                        <g:radio id="modeLight" name="mode" value="false" checked="${(!usuarioInstance?.modoDark ? 'true' : '')}"/>
                        <label for="modeLight"><g:message code="layoutMenu.configuracion.modeLight"/></label>
                    </div>
                </div>

            </div>
            %{-- Pie --}%
            <div class="modal-footer">
                <button id="btnChangePass" type="button" class="button small"><g:message code="layoutMenu.configuracion.changePass"/></button>
                <button id="btnSubmitUser" type="submit" class="button primary small"><g:message code="default.button.create.label"/></button>
            </div>
        </div>

        <g:hiddenField name="id" value="${usuarioInstance.id}"/>

    </g:formRemote>
</div>

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