class BeatHaven.Models.Player extends Backbone.Model
  playlist_on: false
  playlist: null
  tracks: null
  current_track: null

  initialize: ->
    @playlist = new BeatHaven.Collections.Tracklist()
    @tracks = new BeatHaven.Collections.Tracklist()

  play: (track) ->
    unless track?
      if @current_track?
        @current_track.get("sm_obj").resume()
      else
        this.play_something()
    else
      if @current_track?
        @current_track.get("sm_obj").stop()
        $(".player .progress-bar .bar").css(width: 0)
      @current_track = track
      @current_track.get("sm_obj").play()
      $(".player .controls .play").css(display: "none")
      $(".player .controls .pause").css(display: "inline-block")

  pause: ->
    return false unless @current_track?
    @current_track.get("sm_obj").pause()
    $(".player .controls .play").css(display: "inline-block")
    $(".player .controls .pause").css(display: "none")

  next: ->
    return false unless @current_track?
    if @playlist_on
      # not implemented
    else
      nodes = @current_track.node().next()
      return false unless nodes.length == 1
      @tracks.get(parseInt($(nodes[0]).data("id"), 10)).play()

  prev: ->
    return false unless @current_track?
    if @playlist_on
      # not implemented
    else
      nodes = @current_track.node().prev()
      return false unless nodes.length == 1
      @tracks.get(parseInt($(nodes[0]).data("id"), 10)).play()

  play_something: ->
    nodes = $(".artist-page .tracks li[data-id]")
    return false unless nodes.length > 0
    @tracks.get(parseInt($(nodes[0]).data("id"), 10)).play()

  update_title: (params) ->
    $(".player .progress-bar .title").html("#{params.artists.join(', ')} &mdash; #{params.track}")

  update_buffer_bar: (event) ->
    false

  update_progress_bar: (obj) ->
    percent = obj.position / obj.duration * 100
    $(".player .progress-bar .bar").css(width: "#{percent}%")

