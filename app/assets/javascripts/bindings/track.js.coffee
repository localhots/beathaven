$ ->
  $(".track-play").live "mouseup", (e) ->
    e.preventDefault()
    id = parseInt($(this).parent().data("id"), 10)
    BH.Player.playlist_on = false
    BH.Player.tracks.get(id).play()

  $(".track-pause").live "mouseup", (e) ->
    e.preventDefault()
    id = parseInt($(this).parent().data("id"), 10)
    BH.Player.tracks.get(id).pause()

  $(".track-add").live "mouseup", (e) ->
    e.preventDefault()
    id = parseInt($(this).parent().data("id"), 10)

