$(document).ready(function() {
    $('.boxGenero').each(function( index ) {
        var id = $(this).attr('id');
        if(id != 'clonBoxGenero'){
            var listaGenero = obtnerListaGenero();
            listaGenero.push(id);
            $('#listOfGenders').val(listaGenero);
        }
    });
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

