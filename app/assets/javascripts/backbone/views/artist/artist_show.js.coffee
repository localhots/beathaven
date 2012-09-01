class BeatHaven.Views.ArtistShow extends Backbone.View
  template: HoganTemplates["backbone/templates/artist/show"]

  initialize: ->
    @model.on("change", @render, this)

  render: ->
    if typeof @model.get("artist_bio") != "undefined"
      for album_info in @model.get("artist_albums")
        for track_info in album_info.album_tracks
          track = new BeatHaven.Models.Track(track_info.meta)
          BeatHaven.Player.tracks.push(track)
      $(@el).html(@template.render(@model.toJSON()))
    this
