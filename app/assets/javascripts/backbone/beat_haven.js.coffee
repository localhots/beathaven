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

  Player: null
  User: null

  init: ->
    new BeatHaven.Routers.Main()
    new BeatHaven.Routers.Artist()
    new BeatHaven.Routers.Album()
    new BeatHaven.Routers.Search()
    @Player = new BeatHaven.Models.Player()
    @User = new BeatHaven.Models.User()
    @VK = new BeatHaven.Models.VK()

    # @VK.init()

    Backbone.history.start(pushState: true);
    $("a").live "click", (e) ->
      if $(this).attr("href").substr(0, 1) == "/"
        e.preventDefault()
        Backbone.history.navigate($(this).attr("href"), true)
      false

    # Backbone.history.navigate("/tour", true)

  log: (data) ->
    console.log data

$ ->
  BeatHaven.init()

# Setup shortcut
window.BH = window.BeatHaven
