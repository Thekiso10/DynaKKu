function callSpinner(){
    $("#spinner").show();
}

function stopSpinner(){
    $("#spinner").hide();
}

$('#formCreateAutor').submit(function (event) {
    callSpinner();
})

$('#formEditAutor').submit(function (event) {
    callSpinner();
})