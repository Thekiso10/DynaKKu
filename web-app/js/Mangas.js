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
        $('#serieConsecutiva').prop('checked', true);
        $('#serieConsecutiva').prop('disabled', true);

        $('#completado').prop('disabled', true);

        $('#deseado').prop('disabled', true);
    } else {
        $('#serieConsecutiva').prop('checked', false);
        $('#serieConsecutiva').prop('disabled', false);

        $('#completado').prop('disabled', false);

        $('#deseado').prop('disabled', false);
    }
});

$('#serieConsecutiva').change(function(){
    if ($('#serieConsecutiva').is(':checked') == true){
        $('#serieAcabada').prop('disabled', true);

        $('#completado').prop('disabled', true);

        $('#deseado').prop('disabled', true);
    } else {
        $('#serieAcabada').prop('disabled', false);

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

