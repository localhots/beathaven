class BeatHaven.Views.AlbumShow extends Backbone.View
  template: HoganTemplates["backbone/templates/album/show"]

  initialize: ->
    @model.on("change", @render, this)

  render: ->
    if typeof @model.get("album_tracks") != "undefined"
      for track_info in @model.get("album_tracks")
        track = new BeatHaven.Models.Track(track_info.meta)
        BeatHaven.Player.tracks.push(track)
      $(@el).html(@template.render(@model.toJSON()))
    this
