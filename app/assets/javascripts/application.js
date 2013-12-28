// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
//= require rails.validations.simple_form
//= require jquery.tokeninput
//= require rails-timeago
//= require rails-timeago-all



// Searcg box by token input field
$(function() {

  $("#welcome_search input").keyup(function() {
  	$.get($("#welcome_search").attr("action"), $("#welcome_search").serialize(), null, "script");
    return false;
  });

  $(".close").on("click", function(){
     $('.flash_messages').slideUp('slow');
  });


  // For Bootstrap related stuff modal start
  
  $('[data-toggle="modal"]').click(function(e) {
	  e.preventDefault();
	  var url = $(this).attr('href');
	  $.get(url, function(data) {},"script");
  });

  // For Bootstrap related stuff modal end


  // More Less Link stuff start
    $(".less_p").hide();
    $("p[id$=_more_text]").hide();

    $(".more_p a:first").on("click",function(){
        var select = $(this);
        var id = select.attr('id').split("_more_link")[0];
        $("#"+id+"_less_text").hide();
        $("#"+id+"_more_text").show();
        $(".less_p").show();
        select.parent().hide();
    });

    $(".less_p a:first").on("click",function(){
        var select = $(this);
        var id = select.attr('id').split("_less_link")[0];
        $("#"+id+"_more_text").hide();
        $("#"+id+"_less_text").show();
        $(".more_p").show();
        select.parent().hide();
    });
 // More Less Link stuff start


});


// function show_loader_on_submit(){
// 	$(".ajax_form").on("submit",function(){
// 		$("#loder").show();
// 		alert(1);
//     });
// }



