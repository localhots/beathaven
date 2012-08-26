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

  init: ->
    new BeatHaven.Routers.Artist()
    Backbone.history.start();

$ ->
  BeatHaven.init()
