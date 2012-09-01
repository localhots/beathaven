class BeatHaven.Routers.Album extends Backbone.Router
  routes:
    "album/:id": "show"

  show: (id) ->
    album = new BeatHaven.Models.Album(id: id)
    album.fetch()
    view = new BeatHaven.Views.AlbumShow(model: album)
    $("#main").html(view.render().el)
