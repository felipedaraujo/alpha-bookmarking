# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http: //coffeescript.org/

jQuery ->
  $("#add_link").click ->
    url = $("#bookmark_url")
    url_val = url.val()
    title = $("#bookmark_title")
    tag_list = $("#bookmark_tag_list")

    if ($.trim(url_val).length > 0)
      if (url_val && !url_val.match(/^http([s]?):\/\/.*/))
        url.val('http://' + url_val)
      title.prop('disabled', false)
      tag_list.prop('disabled', false)
      title.focus()
      $("#add_link").hide()
      $("input[type='submit']").show()
      $.get('/add_link',
        { url: url_val },
        (data) ->
          title.val(data.title)
          tag_list.val(data.list)
      )
    else
      alert "The URL field can't be blank"
      url.val("")
      url.focus()
  
  $('a.copy').click ->
    window.prompt("Push Ctrl+C to copy", $(this).parent().prev().val());

  $(document).keypress (e) ->
    search($("#searchInput").val()) if(e.which == 13)
  
  $("#searchBtn").click ->
    search($("#searchInput").val())

search = (input) ->
  if input.substr(0,1) == '#'
    tag = input.substr(1,input.length - 1)
    window.location.href = "/search_by_tag?key=" + tag
  else if  '' in [input, input.trim()]
    alert "Search can't be blank!"
  else
    window.location.href = "/search?key=" + input
