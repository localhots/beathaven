class BeatHaven.Routers.Search extends Backbone.Router
  routes:
    "search/:query": "search"

  search: (query) ->
    $(".navbar-search .search-query").attr("disabled", "disabled").blur()
    $.ajax(
      url: "/api/search/wtfis?q=#{query}"
      success: (data) ->
        if data.found?
          Backbone.history.navigate(data.found, true)
          $(".navbar-search .search-query").val("").removeAttr("disabled")
        else
          alert "Not found! :("
          $(".navbar-search .search-query").removeAttr("disabled").focus()
    )
