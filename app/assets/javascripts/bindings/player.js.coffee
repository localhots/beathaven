$ ->
  $(".player .controls .prev").live "click", (e) ->
    BH.Player.prev()
  $(".player .controls .play").live "click", (e) ->
    BH.Player.play()
  $(".player .controls .pause").live "click", (e) ->
    BH.Player.pause()
  $(".player .controls .next").live "click", (e) ->
    BH.Player.next()
  $(".player .controls .playlist-toggle").live "click", (e) ->
    $(".playlist").toggle()

  $(".player .move-it")
    .live "mousedown", (e) ->
      BH.Player.move_it_mousedown = true
    .live "mouseup", (e) ->
      BH.Player.move_it_mousedown = false
      return false unless BH.Player.current_track?
      percent = e.offsetX / $(this).width()
      BH.Player.seek(percent)
    .live "mousemove", (e) ->
      return false unless BH.Player.move_it_mousedown and BH.Player.current_track?
      percent = e.offsetX / $(this).width() * 100
      $(".player .progress-bar .bar").css(width: "#{percent}%")
