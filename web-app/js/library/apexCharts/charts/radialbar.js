function radialbar_basic() {
    return null;
}

function radialbar_gradient(percentTomoms, modeDark, text, startAngle, endAngle) {
    var listColors = getColorsRadialbar(modeDark);

    var objectRadialbar = {
        series: [percentTomoms],
        chart: {
            height: 350,
            width: 350,
            type: 'radialBar'
        },
        plotOptions: {
            radialBar: {
                startAngle: startAngle,
                endAngle: endAngle,
                hollow: {
                    margin: 0,
                    size: '70%',
                    background: 'transparent',
                    image: undefined,
                    imageOffsetX: 0,
                    imageOffsetY: 0,
                    position: 'front',
                    dropShadow: {
                        enabled: true,
                        top: 3,
                        left: 0,
                        blur: 4,
                        opacity: 0.24
                    }
                },
                track: {
                    background: listColors.trackBackground,
                    strokeWidth: '67%',
                    margin: 0, // margin is in pixels
                    dropShadow: {
                        enabled: true,
                        top: -3,
                        left: 0,
                        blur: 4,
                        opacity: 0.35
                    }
                },
                dataLabels: {
                    show: true,
                    name: {
                        offsetY: -10,
                        show: true,
                        color: listColors.dataLabelsNameColor,
                        fontSize: '17px'
                    },
                    value: {
                        formatter: function(val) {
                            return parseInt(val) + '%';
                        },
                        color: listColors.dataLabelsValueColor,
                        fontSize: '36px',
                        show: true,
                    }
                }
            }
        },
        fill: {
            type: 'gradient',
            gradient: {
                shade: 'dark',
                type: 'horizontal',
                shadeIntensity: 0.5,
                gradientToColors: listColors.gradientToColors,
                inverseColors: true,
                opacityFrom: 1,
                opacityTo: 1,
                stops: [0, 100]
            }
        },
        stroke: {
            lineCap: 'round'
        },
        labels: [text],
    };

    return objectRadialbar;
}

function getColorsRadialbar(modeDark){
    var listColors = {}; //Creamos a dicionario

    if(modeDark == true){
        listColors.gradientToColors = ['#56AFDC', '#2689BA'];
        listColors.dataLabelsNameColor = '#fff';
        listColors.dataLabelsValueColor = '#fff';
        listColors.trackBackground = '#071922';
    }else{
        //TODO: Aquí va los colores en modo claro
    }

    return listColors;
}