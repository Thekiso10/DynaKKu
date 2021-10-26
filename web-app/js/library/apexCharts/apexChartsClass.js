function radialBarNumTomos(percentTomoms, mode_dark, text){


    var chart = new ApexCharts(document.querySelector("#Radial-Bar-Num-Tomos"), radialbar_gradient(percentTomoms, text, -180, 180));
    chart.render();
}

function radialBarMangasCompletos(percentColleciones, mode_dark, text){
    var chart = new ApexCharts(document.querySelector("#Radial-Bar-Mangas-Completos"), radialbar_gradient(percentColleciones, text, 0, 360));
    chart.render();
}
