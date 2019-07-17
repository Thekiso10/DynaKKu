function modificarIconoMenu(boton){
	var span = $(boton).find("span");
	var iconDown = span.hasClass("glyphicon-chevron-down");
	
	resetearIconosMenu();	
	span.removeClass();
	
	if(iconDown){
		span.addClass("glyphicon-chevron-up");
	}else{
		span.addClass("glyphicon-chevron-down");
	}
	
	span.addClass("glyphicon");
}

function resetearIconosMenu(){
	$(".dropdown").each(function() {
		  var icono = $(this).find(".btnExtra").find("span")
		  icono.removeClass();
		  icono.addClass("glyphicon");
		  icono.addClass("glyphicon-chevron-down");
	});
}

function comprobarMenusAbiertos(){
	var reset = true;
	
	$(".dropdown").each(function() {
		if($(this).hasClass("open")){
			reset = false;
		}
	});
	
	if(reset)resetearIconosMenu();
}

$(document).on('click.bs.dropdown.data-api', comprobarMenusAbiertos)

