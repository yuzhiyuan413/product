// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require fakeloader.min
//= require fileinput

function appendNotice(content){
	$("#notice").html("<i class=\"close icon\"></i><p id=\"notice_msg\">"+content+"</p>");
	$(".close").on("click",function(){
	  $("#notice").html("").slideUp(1000)
	})
}

$(function(){
  $(".login_container .close").click(function(){
    $(this).parent().hide();
  })
})
