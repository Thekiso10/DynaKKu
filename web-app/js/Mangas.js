$('#completado').change(function(){
    if ($('#completado').is(':checked') == true){
        $('#serieAcabada').prop('checked', true);
        $('#serieAcabada').prop('disabled', true);

        $('#serieConsecutiva').prop('checked', true);
        $('#serieConsecutiva').prop('disabled', true);

        $('#deseado').prop('disabled', true);
    } else {
        $('#serieAcabada').prop('checked', false);
        $('#serieAcabada').prop('disabled', false);

        $('#serieConsecutiva').prop('checked', false);
        $('#serieConsecutiva').prop('disabled', false);

        $('#deseado').prop('disabled', false);
    }
});

$('#serieAcabada').change(function(){
    if ($('#serieAcabada').is(':checked') == true){
        $('#completado').prop('disabled', true);

        $('#deseado').prop('disabled', true);
    } else {
        $('#completado').prop('disabled', false);

        $('#deseado').prop('disabled', false);
    }
});

$('#serieConsecutiva').change(function(){
    if ($('#serieConsecutiva').is(':checked') == true){
        $('#completado').prop('disabled', true);

        $('#deseado').prop('disabled', true);
    } else {
        $('#completado').prop('disabled', false);

        $('#deseado').prop('disabled', false);
    }
});

$('#deseado').change(function(){
    if ($('#deseado').is(':checked') == true){
        $('#serieConsecutiva').prop('disabled', true);

        $('#completado').prop('disabled', true);

        $('#serieAcabada').prop('disabled', true);
    } else {
        $('#serieConsecutiva').prop('disabled', false);

        $('#completado').prop('disabled', false);

        $('#serieAcabada').prop('disabled', false);
    }
});

function obtnerListaGenero() {
    var listaGeneroString = $('#listOfGenders').val();
    var listaGeneros = [];
    if (listaGeneroString && listaGeneroString !== ""){
        listaGeneros = listaGeneroString.trim().replace('[', '').replace(']', '').split(',');
    }
    return listaGeneros
}

function comprobarLista(list, text) {
    var noIgual = true;

    for(var i=0; i < list.length; i++){
        if(list[i] == text){
            noIgual = false;
        }
    }
    return noIgual;
}

function agregarGenero(){
    var listaGenero = obtnerListaGenero();
    var valorSelect = $('#Generos').val();
    var textSelect = $("#Generos option:selected").text();

    if(valorSelect == 'null' || !comprobarLista(listaGenero, valorSelect)) {
        return;
    }
    //Clonar caja de genero
    $('#clonBoxGenero').clone(true).attr("id",valorSelect).appendTo("#boxesGeneros");

    $('#' + valorSelect).children('span.boxNombreGenero').text(textSelect);
    $('#' + valorSelect).removeClass('hidden');

    listaGenero.push(valorSelect);
    $('#listOfGenders').val(listaGenero);
}

$('#agreeGenero').click(function() {
    agregarGenero();
});

$('.closeGenero').click(function() {
    var idElemento = $(this).parent().attr('id');
    var listaGenero = obtnerListaGenero();

    var index = listaGenero.indexOf(idElemento);
    if (index > -1) {
        listaGenero.splice(index, 1);
    }

    $('#' + idElemento).remove();
    $('#listOfGenders').val(listaGenero);
});

