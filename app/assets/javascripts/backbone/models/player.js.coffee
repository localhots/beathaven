class BeatHaven.Models.Player extends Backbone.Model
  playlist_on: false
  playlist: null
  tracks: null
  current_track: null
  move_it_mousedown: false

  initialize: ->
    @playlist = new BeatHaven.Modules.Playlist()
    @tracks = new BeatHaven.Collections.Tracklist()

  #
  # Actions
  #

  play: (track) ->
    unless track?
      if @current_track?
        @current_track.get("sm_obj").resume()
      else
        this.play_something()
    else
      if @current_track? and @current_track == track
        @current_track.get("sm_obj").play()
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

  seek: (percent) ->
    return false unless @current_track?
    position = @current_track.get("duration") * 1000 * percent
    @current_track.get("sm_obj").setPosition(position)

  next: ->
    return false unless @current_track?
    if @playlist_on
      # not implemented
    else
      node = $(".tracks li.now-playing").neighbour(".tracks li", 1)
      return false unless node?
      @tracks.get(parseInt($(node).data("id"), 10)).play()

  prev: ->
    return false unless @current_track?
    if @playlist_on
      # not implemented
    else
      node = $(".tracks li.now-playing").neighbour(".tracks li", -1)
      return false unless node?
      @tracks.get(parseInt($(node).data("id"), 10)).play()

  play_something: ->
    nodes = $(".artist-page .tracks li[data-id]")
    return false unless nodes.length > 0
    @tracks.get(parseInt($(nodes[0]).data("id"), 10)).play()

  #
  # Playlist
  #

  add_track_to_playlist: (track) ->
    @playlist.add(track).render()

  remove_track_from_playlist: (track) ->
    @playlist.remove(track).render()

  #
  # Supportive
  #

  update_title: (params) ->
    $(".player .progress-bar .title").html("#{params.artists.join(', ')} &mdash; #{params.track}")

  update_buffer_bar: (event) ->
    # not implemented
    false

  update_progress_bar: (obj) ->
    return false if @move_it_mousedown
    percent = obj.position / obj.duration * 100
    $(".player .progress-bar .bar").css(width: "#{percent}%")
