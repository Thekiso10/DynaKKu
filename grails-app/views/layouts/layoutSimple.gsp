<!DOCTYPE html>
<html lang="es" class="no-js">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title><g:layoutTitle default="DynaKKu"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <g:external dir="images/imgWeb/icons" file="favicon.ico"/>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'layoutMain.css')}" type="text/css">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'flashMessage.css')}" type="text/css">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'colores/nightMode.css')}" type="text/css">
        <asset:stylesheet src="application.css"/>
        <asset:javascript src="application.js"/>
        <g:layoutHead/>
    </head>
    <body>
        <div id="layout-container" class="container-fluid">
            %{--	Header Template	--}%
            <g:render  template="/layouts/templates/header"/>
            %{--    Cuerpo de las vistas    --}%
            <g:layoutBody/>
            %{--    Spinner    --}%
            <div id="spinner" class="spinner" style="display:none;">
                <img id="img-spinner" src="${resource(dir: 'images/imgWeb', file: 'spinner.gif')}" alt="Loading"/>
            </div>
        </div>
        %{--    Footer    --}%
        <g:render template="/layouts/templates/footer"/>

        <div id="cookiesPopUp">
            <g:render template="/layouts/templates/popUpCookies" ></g:render>
        </div>

        <%-- Hacer la importacion de archivos --%>
        <g:javascript src="CookiesService.js"/>
    </body>
</html>