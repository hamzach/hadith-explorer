var callbackvar = 0;
$(document).ready(function(){	
	$(".add-collection").click(function(e)
		var btnText = $(e.target).text();
		var base = 'addcollection';
		var id = $(e.target).attr("value");
		
		if(btnText.trim() == "Add to my collection")
		{
			$(e.target).html("<span class='glyphicon glyphicon-heart' aria-hidden='true'></span>&nbsp&nbspRemove from collection");
			
			$(e.target).addClass("active-button");
			$().toastmessage('showSuccessToast', "Hadith added to my collection.");
		}
		else
		{
			$(e.target).html("<span class='glyphicon glyphicon-heart' aria-hidden='true'></span>&nbsp&nbspAdd to my collection");
			
			$(e.target).removeClass("active-button");
			$().toastmessage('showSuccessToast', "Hadith remove from my collection.");
		}

		$.ajax(
        {
	        type:'get',
	        url:base,
	        data:{hadith_id:id, button_text:btnText},
	        success:function(response)
	        {
	            //alert(response);
	        },
	        error: function()
	        {
	        	alert('Load was performed.');
	    	}
 		});

	});

	$(".save-category").click(function(e){
		if(callbackvar)
		{
			$(".not-catogorized").hide();
			$(".categorized").removeClass("hidden");
		}

		selected = new Array();
		$(".categories input[type='checkbox']:checked").each(function(e)
		{
			selected.push($(this).val().toString());
		});

		var base = 'addcategory';
		var id = $(".hadith_id").text();
		// alert(selected);
		$.ajax(
        {
	        type:'get',
	        url:base,
	        data:{hadith_id:id, categories:selected},
	        success:function(response)
	        {
	        	alert(response);
	        	if(selected.length > 0)
	        	{
	        		html = "";
	        		for (var i = 0; i < selected.length; i++) 
	        		{
	        			html += "<p class=\"row col-lg-2\" style=\"display:inline-flex;\">"+selected[i]+"</p>";
	        		};
	        		
	        		$("#"+id+"_categories_container").html(html);
	        		
	        		$(".categories input[type='checkbox']:checked").each(function(e)
					{
						$(this).prop('checked', false);
	    			});
	        	}
	        	else
	        	{
	        		$("#"+id+"_categories_container").html("The hadith is yet to be categorized.");
	        	}
	        },
	        error: function(e)
	        {
	        	$("#hadithModal").html(JSON.stringify(e, null, 4).toString());
	    	}
 		});
 		$(e.target).html("<span class='glyphicon glyphicon-saved' aria-hidden='true'></span>&nbsp&nbspCategory Saved");
		$(e.target).addClass("active-button");

		$().toastmessage('showSuccessToast', "Category saved.");
	});

	$(".active-button").hover(function(e){


	});

	$(".glyphicon-search").on("click" ,function(){
		//$('.sidebar-nav').scrollTop($('.sidebar-nav')[0].scrollHeight);
		
       //$('.lll').offsetTop = "10px";
        $(".sidebar-nav").scrollTop(10);

	});
    $(".editCategory").click(function(e){
    	var id = $(e.target).attr("value");
    	if(e.target.id=="forTest"){
    		callbackvar = 1;
    	}else {
    		callbackvar = 0;
    	}
    	
    	$(".modal-narrators").html($(e.target).closest(".hadith").find(".narrators").html());
    	$(".modal-matan").html($(e.target).closest(".hadith").find(".matan").html()+"<span class = 'hidden hadith_id'>"+id+"</span>");
    	//($($(e.target).closest(".hadith").find(".narrators").html())).insertBefore($($(".hadithModal").find(".categories")));
        //$(".hadith-modal-footer").html($(".editCategory").closest(".hadith").html());
        $('#hadithModal').modal('show');
    });

    $('#hadithModal').on('hidden.bs.modal', function () 
    {
    	$("#save_category").html("<span class='glyphicon glyphicon-save' aria-hidden='true'></span>&nbsp&nbspSave Category");
		$("#save_category").removeClass("active-button");
	});

	$(".lll ").mCustomScrollbar({
			theme:"minimal-dark"
	});
	 
	NProgress.configure({
	  template: '<div class="bar" role="bar"><div class="peg"></div></div><div class="spinner" role="spinner"><div class="spinner-icon"></div></div>',
	  parent: "#soe",
	  showSpinner: false
	});
	$("body").addClass(".disabled");
	$('#myModal').modal({
	  backdrop: 'static',
	  keyboard: false
	});

	$('#myModal').modal('show');
	NProgress.start();
	function some(){ 
		$(".bar").toggleClass("black-shadow-line");
		setTimeout(some, 2500);
	};
	some();

});
$(window).load(function(){
	setTimeout(function(){ 

	NProgress.done();
	$("body").removeClass(".disabled");
	$('#myModal').modal('hide');
}, 0);
			});


$("#advc-icon").click(function(e)
{
	var visibility = $(".advc-search").css('visibility');
	if(visibility == 'visible')
	{
		$(".advc-search").css('visibility', 'hidden');
	}
	else
	{
		$(".advc-search").css('visibility', 'visible');	
	}
});

$("#aSearch").click(function(e)
{
	var book = $("#bookId").val().toString();
	var narrator = $("#narratorId").val().toString();
	var topic = $("#topicId").val().toString();
	var category = $("#categoryId").val().toString();
	
	var base = 'advanceSearch'
	$.ajax(
    {
        type:'get',
        url:base,
        data:{bookText:book, narratorText:narrator, topicText:topic, categoryText:category},
        dataType:'json',
        success:function(response)
        {
        	$("#mainContent").html(response);
        },
        error: function(e)
        {
     	  alert(JSON.stringify(e, null, 4).toString());
    	}
		});
});