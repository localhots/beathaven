class BeatHaven.Modules.Playlist
  selector: ".playlist"
  tracks: null

  initialize: ->
    @tracks = new BeatHaven.Collections.Tracklist()
