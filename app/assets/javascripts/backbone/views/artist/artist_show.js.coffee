class BeatHaven.Views.ArtistShow extends Backbone.View
  template: HoganTemplates["artist/show"]

  initialize: ->
    @model.on("change", @render, this)

  render: ->
    if typeof @model.get("artist_bio") != "undefined"
      for album_info in @model.get("artist_albums")
        album_info["i18n_add"] = BH.I18n.t("artist.album.add")
        album_info["i18n_play"] = BH.I18n.t("artist.album.play")
        for track_info in album_info.album_tracks
          track_info["i18n_add"] = BH.I18n.t("artist.album.track.add")
          track_info["i18n_play"] = BH.I18n.t("artist.album.track.play")
          track_info["i18n_pause"] = BH.I18n.t("artist.album.track.pause")
          track = new BeatHaven.Models.Track(track_info.meta)
          BeatHaven.Player.tracks.push(track)
      $(@el).html(@template.render(@model.toJSON()))
    this
