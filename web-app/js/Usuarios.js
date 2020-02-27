function resetFlashMessage() {
    if(!$( "#closerFlashGood" ).hasClass("hidden")){
        $("#userFlashCorrecto").addClass('hidden');
    }

    if(!$( "#closerFlashError" ).hasClass("hidden")){
        $("#userFlashError").addClass('hidden');
    }
}

$('#closerFlashGood').click(function() {
    $("#userFlashCorrecto").addClass('hidden');
});

$('#closerFlashError').click(function() {
    $("#userFlashError").addClass('hidden');
});

$('#btnChangePass').click(function() {
    if($("#changePassword").hasClass("hidden")){
        $("#changePassword").removeClass('hidden');
        document.getElementById("changePasswordParam").value = true;
    }else{
        $("#changePassword").addClass('hidden');
        document.getElementById("changePasswordParam").value = false;
    }

    document.getElementById('passwordField').value = "";
    document.getElementById('repitPasswordField').value = "";
});

$('#btnBackUser').click(function() {
    resetFlashMessage();
});

$('#closePopupUser').click(function() {
    resetFlashMessage();
});