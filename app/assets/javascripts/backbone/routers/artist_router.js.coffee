class BeatHaven.Routers.Artist extends Backbone.Router
  routes:
    "artist/:name": "show"

  show: (name) ->
    artist = new BeatHaven.Models.Artist(id: name)
    artist.fetch()
    view = new BeatHaven.Views.ArtistShow(model: artist)
    $("#main").html(view.render().el)
