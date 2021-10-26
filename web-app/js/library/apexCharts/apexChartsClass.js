function createRadialbarCharts(selector, percent, modeDark, text, startAngle, endAngle){
    var chart = new ApexCharts(selector, radialbar_gradient(percent, modeDark, text, startAngle, endAngle));
    chart.render();
}