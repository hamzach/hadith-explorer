
$(document).ready(function(){
	$(".categoriesSearch").on("change",function(){
		alert("s");
	});	

	$('#myCollection').click(function(){
	    //$('#myCollection').css({"background":"skyblue","color":"#000"});
	    $('#myCollection').addClass("active");
	    $('#myCollection').animate({height:'50px'}, 500);

	    //this method increases the height to 72px
	});
});


