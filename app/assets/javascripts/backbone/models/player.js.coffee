class BeatHaven.Models.Player extends Backbone.Model
  playlist_on: false
  playlist: null
  tracks: null

  initialize: ->
    @playlist = new BeatHaven.Collections.Tracklist()
    @tracks = new BeatHaven.Collections.Tracklist()

  update_title: (params) ->
    $(".player .progress-bar .title").html("#{params.artists.join(', ')} &mdash; #{params.track}")
