$ ->
  $(".navbar-search input").focus ->
    $(this).animate(width: 249)
    $(".player").animate(width: 368)
  $(".navbar-search input").blur ->
    $(this).animate(width: 99)
    $(".player").animate(width: 518)

  window.desired = $(".navbar-search input").autocomplete
    serviceUrl: "/api/search/complete.json"
    onSelect: (selected) ->
      Backbone.history.navigate("/search/"+selected.replace(/\s/g, "+"), true)
