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
    var url = $("#bookmark_url").val()

    if ($.trim(url).length > 0){
      if (url && !url.match(/^http([s]?):\/\/.*/)) {
        $("#bookmark_url").val('http://' + url);
      }
     
      $("#bookmark_title").prop('disabled', false);
      $("#bookmark_tag_list").prop('disabled', false);

      $("#bookmark_title").focus();

      $("#add_link").hide();
      $("input[type='submit']").show();

      $.get('/add_link', {
          url: url
        },
        function(data) {
          $("#bookmark_title").val(data.title);
          $("#bookmark_tag_list").val(data.list);
        });
    }else{
      alert("The URL field can't be blank");
      $("#bookmark_url").val("")
      $("#bookmark_url").focus();
    }
  });


  $('a.copy').click(function() {
    window.prompt("Push Ctrl+C to copy",
      $(this).parent().prev().val());
  });

  $(document).keypress(function(e) {
    if(e.which == 13) {
      search($("#searchInput").val());
    }
  });

  $("#searchBtn").click(function(){
      search($("#searchInput").val());
  });


});


function search(input) {

  if(input.substr(0,1) == '#'){
    var tag = input.substr(1,input.length - 1)
    window.location.href = "/search_by_tag?key=" + tag;
  } 
  else if( input == "" || input.trim() == "") {
    alert("Search can't be blank!");
  }
  else{
    window.location.href = "/search?key=" + input;
  }
}
