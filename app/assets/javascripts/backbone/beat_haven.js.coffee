#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers
#= require ./i18n

window.BeatHaven =
  Modules: {}
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

  Player: null
  User: null
  I18n: null
  locales: {}

  init: ->
    new BeatHaven.Routers.Main()
    new BeatHaven.Routers.Artist()
    new BeatHaven.Routers.Album()
    new BeatHaven.Routers.Search()
    @Player = new BeatHaven.Models.Player()
    @User = new BeatHaven.Models.User()
    @VK = new BeatHaven.Models.VK()
    @I18n = new BeatHaven.Modules.I18n()

    # @VK.init()

    Backbone.history.start(pushState: true);
    $("a").live "click", (e) ->
      if $(this).attr("href").substr(0, 1) == "/"
        e.preventDefault()
        Backbone.history.navigate($(this).attr("href"), true)
      false

    # Backbone.history.navigate("/tour", true)
    @I18n.init()

  log: (data) ->
    console.log data

$ ->
  BeatHaven.init()

# Setup shortcut
window.BH = window.BeatHaven
