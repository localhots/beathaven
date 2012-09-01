$ ->
  $(".track-play").live "click", (e) ->
    e.preventDefault()
    id = parseInt($(this).parent().data("id"), 10)
    BH.Player.tracks.get(id).play()
