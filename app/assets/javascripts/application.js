// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.autocomplete
//= require turbolinks
//= require_tree .

$(document).ready(function() {

  $("#add_link").click(function() {
    $("#bookmark_title").prop('disabled', false);
    $("#bookmark_tag_list").prop('disabled', false);

    $("#bookmark_title").focus();

    $("#add_link").hide();
    $("input[type='submit']").show();

    var url = $("#bookmark_url").val();
    $.get('/add_link', {
        url: url
      },
      function(data) {
        $("#bookmark_title").val(data.title);
        $("#bookmark_tag_list").val(data.list);
      });
  });


  $('a.copy').click(function() {
    window.prompt("Push Ctrl+C to copy",
      $(this).parent().prev().val());
  });

  $("#searchBtn").click(function(){
    if($("#searchInput").val().substr(0,1) == '#'){
      var input = $("#searchInput").val();
      window.location.href = "/search_by_tag?key=" + input.substr(1,input.length - 1);
    }
    else{
      window.location.href = "/search?key=" + $("#searchInput").val();
    }  
  });


});

