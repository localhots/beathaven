class BeatHaven.Routers.Main extends Backbone.Router
  routes:
    "tour": "tour"

  tour: ->
    view = new BeatHaven.Views.MainTour()
    $(".tour").html(view.render().el)
