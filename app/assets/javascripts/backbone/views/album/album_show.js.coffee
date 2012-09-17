class BeatHaven.Views.AlbumShow extends Backbone.View
  template: HoganTemplates["album/show"]

  initialize: ->
    @model.on("change", @render, this)

  render: ->
    if typeof @model.get("album_tracks") != "undefined"
      @model.set "i18n_add", BH.I18n.t("artist.album.add")
      @model.set "i18n_play", BH.I18n.t("artist.album.play")
      for track_info in @model.get("album_tracks")
        track_info["i18n_add"] = BH.I18n.t("artist.album.track.add")
        track_info["i18n_play"] = BH.I18n.t("artist.album.track.play")
        track_info["i18n_pause"] = BH.I18n.t("artist.album.track.pause")
        track = new BeatHaven.Models.Track(track_info.meta)
        BeatHaven.Player.tracks.push(track)
      $(@el).html(@template.render(@model.toJSON()))
    this
