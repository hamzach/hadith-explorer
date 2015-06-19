
/* SQUARE HEADER NAVIGATION */
$( "#op_1" ).click(function() {
  $('.square_option').removeClass('selected'); $('.options ul li').removeClass('selected');
       $('#op_1').addClass('selected');
/*       $('html,body').animate({
    		scrollTop: $("#cntnt_1").offset().top},
        'slow');*/
});
$( "#op_2" ).click(function() {
  $('.square_option').removeClass('selected'); $('.options ul li').removeClass('selected');
       $('#op_2').addClass('selected');
	   $('#oh_o1').addClass('selected');
       $('html,body').animate({
        scrollTop: $("#cntnt_1").offset().top},
        'slow');
});
$( "#op_3" ).click(function() {
  $('.square_option').removeClass('selected'); $('.options ul li').removeClass('selected');
       $('#op_3').addClass('selected');
	   $('#oh_o2').addClass('selected');
       $('html,body').animate({
        scrollTop: $("#cntnt_2").offset().top},
        'slow');
});
/*$( "#op_4" ).click(function() {
  $('.square_option').removeClass('selected'); $('.options ul li').removeClass('selected');
       $('#op_4').addClass('selected');
       $('html,body').animate({
        scrollTop: $("#cntnt_4").offset().top},
        'slow');
});*/

/*$( "#op_6" ).click(function() {
  $('.square_option').removeClass('selected'); $('.options ul li').removeClass('selected');
       $('#op_6').addClass('selected');
       $('html,body').animate({
        scrollTop: $("#cntnt_5").offset().top},
        'slow');
});*/
$( "#op_7" ).click(function() {
  $('.square_option').removeClass('selected'); $('.options ul li').removeClass('selected');
       $('#op_7').addClass('selected');
	   $('#oh_o3').addClass('selected');
       $('html,body').animate({
        scrollTop: $("#cntnt_3").offset().top},
        'slow');
});
$( "#op_8" ).click(function() {
  $('.square_option').removeClass('selected'); $('.options ul li').removeClass('selected');
       $('#op_8').addClass('selected');
	   $('#oh_o4').addClass('selected');
       $('html,body').animate({
        scrollTop: $("#cntnt_4").offset().top},
        'slow');
});
$( "#op_9" ).click(function() {
  $('.square_option').removeClass('selected'); $('.options ul li').removeClass('selected');
       $('#op_9').addClass('selected');
	   $('#oh_o5').addClass('selected');
       $('html,body').animate({
        scrollTop: $("#cntnt_5").offset().top},
        'slow');
});

/* SQUARE OPTION HOVER EFFECT*/
$( "#op_1" ).hover(function() {
  /*$('.square_option').removeClass('selected'); $('.options ul li').removeClass('selected');
        $('#op_1').addClass('selected');*/
      //  $("#op_1").css({"background":"#ffffff"})
});
/*$( "#op_2" ).hover(function() {
  $('.square_option').removeClass('selected'); $('.options ul li').removeClass('selected');
        $('#op_2').addClass('selected');
});
$( "#op_3" ).hover(function() {
  $('.square_option').removeClass('selected'); $('.options ul li').removeClass('selected');
       $('#op_3').addClass('selected');
});
$( "#op_4" ).hover(function() {
  //change image of this area
  //$("#op_4").css("background", "url('4 trawlers.JPG') no-repeat");
});
$( "#op_6" ).hover(function() {
  
});
$( "#op_7" ).hover(function() {
  $('.square_option').removeClass('selected'); $('.options ul li').removeClass('selected');
        $('#op_7').addClass('selected');
});
$( "#op_8" ).hover(function() {
  $('.square_option').removeClass('selected'); $('.options ul li').removeClass('selected');
        $('#op_8').addClass('selected');
});
$( "#op_9" ).hover(function() {
  $('.square_option').removeClass('selected'); $('.options ul li').removeClass('selected');
        $('#op_9').addClass('selected');
});
$(".square_option").mouseout(function() {
  $('.square_option').removeClass('selected');
});*/


/* BAR NAVIGATION */
$( "#oh_o1" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o1').addClass('selected');
	   $('#op_2').addClass('selected');
       $('html,body').animate({
    		scrollTop: $("#cntnt_1").offset().top},
        'slow');
});
$( "#oh_o2" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o2').addClass('selected');
	   $('#op_3').addClass('selected');
       $('html,body').animate({
        scrollTop: $("#cntnt_2").offset().top},
        'slow');
});
$( "#oh_o3" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o3').addClass('selected');
	   $('#op_7').addClass('selected');
       $('html,body').animate({
        scrollTop: $("#cntnt_3").offset().top},
        'slow');
});
$( "#oh_o4" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o4').addClass('selected');
	   $('#op_8').addClass('selected');
       $('html,body').animate({
        scrollTop: $("#cntnt_4").offset().top},
        'slow');
});
$( "#oh_o5" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o5').addClass('selected');
	   $('#op_9').addClass('selected');
       $('html,body').animate({
        scrollTop: $("#cntnt_5").offset().top},
        'slow');
});
$( "#oh_o6" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o6').addClass('selected');
       $('html,body').animate({
        scrollTop: $("#cntnt_6").offset().top},
        'slow');
});
$( "#oh_o7" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o7').addClass('selected');
       $('html,body').animate({
        scrollTop: $("#cntnt_7").offset().top},
        'slow');
});
$( "#oh_o8" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o8').addClass('selected');
       $('html,body').animate({
        scrollTop: $("#cntnt_8").offset().top},
        'slow');
});


/* BAR NAVIGATION */
/*$( "#oh_o2" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o2').addClass('selected');
      
});
$( "#oh_o3" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o3').addClass('selected');
       
});
$( "#oh_o4" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o4').addClass('selected');
       
});
$( "#oh_o5" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o5').addClass('selected');
       
});
$( "#oh_o6" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o6').addClass('selected');
       
});
$( "#oh_o7" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o7').addClass('selected');
      
});
$( "#oh_o8" ).click(function() {
  $('.options ul li').removeClass('selected'); $('.square_option').removeClass('selected');
       $('#oh_o8').addClass('selected');
       
});*/






$( "#power_section_btn" ).click(function() {
 var nav = $('#power_section_type').val();
 if(nav=='power_section_1')
 {
    $('#power_section_type').val('power_section_2');
    $('#power_section_1').fadeOut(0);
    $('#power_section_2').fadeIn(1000);
 }
 else if(nav=='power_section_2')
 {
      $('#power_section_type').val('power_section_3');
      $('#power_section_2').fadeOut(0);
      $('#power_section_3').fadeIn(1000);
 }
 else if(nav=='power_section_3')
 {
    $('#power_section_type').val('finished');
    $('#power_section_3').fadeOut(0);
    $('#power_section_btn').fadeOut(0);
      $('#power_done').fadeIn(1000);
    
 }

});