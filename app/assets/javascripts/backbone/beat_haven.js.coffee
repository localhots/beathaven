#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.BeatHaven =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  player: null

  init: ->
    new BeatHaven.Routers.Artist()
    new BeatHaven.Routers.Album()
    new BeatHaven.Routers.Search()
    @player = new BeatHaven.Models.Player()

    Backbone.history.start(pushState: true);
    $("a").live "click", (e) ->
      if $(this).attr("href").substr(0, 1) == "/"
        e.preventDefault()
        Backbone.history.navigate($(this).attr("href"), true)
        return false
      else
        alert "Window close attempt!"
        return false
      true

$ ->
  BeatHaven.init()
