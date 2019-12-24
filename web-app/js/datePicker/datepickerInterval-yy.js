/**
 * 
 */
$(document).ready(function() {
	 var datepickerOptions = { weekStart:1,  format:'dd/mm/yy', autoclose:true, language: 'es'};
		$(".datepicker").datepicker(datepickerOptions);
		$("#startDate.datepicker").on("changeDate", function(e) {
			$("#endDate.datepicker")
				.datepicker("remove")
				.datepicker({ format:'dd/mm/yy', weekStart:1, autoclose:true,"startDate":e.date, language: 'es'});
		});
	    $("#model").change(); 		    
}); 