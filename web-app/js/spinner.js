function callSpinner(){
    $("#spinner").show();
}

$('#formCreateAutor').submit(function (event) {
    callSpinner();
})

$('#formEditAutor').submit(function (event) {
    callSpinner();
})