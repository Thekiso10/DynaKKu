$(document).ready(function(){
    checkCookie();
});

function setCookie(cNombre, cValor, cDate){
    var d = new Date();
    d.setTime(d.getTime() + (cDate * 24 * 60 * 60 * 1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cNombre + "=" + cValor + ";" + expires + ";path=/";
}

function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function generarPopUp(){
//si se tiene que mostrar el PopUp, modificar sus valores por defecto
    $("#popUp").css("visibility", "visible");
    $("#solutionPopUp").fadeIn('slow');
}

function checkCookie(){
    var ck = getCookie("cb-enabled");

    if(ck != ""){
        //si existe la cookie
        if(ck === "0"){
            //si no está aceptada, mostrar PopUp
            generarPopUp();

        }
    }else{
        //si no existe, crear y mostrar
        setCookie("cb-enabled", "0", 365);
        generarPopUp();
    }
}

$("#cookiesAccept").click(function(){
//al aceptar, ocultar y modificar valor cookie
    $("#popUp").fadeOut('slow');
    setCookie("cb-enabled", "1", 365);
});