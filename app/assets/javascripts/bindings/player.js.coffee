$ ->
  $(".player .controls .prev").live "click", (e) ->
    BH.Player.prev()
  $(".player .controls .play").live "click", (e) ->
    BH.Player.play()
  $(".player .controls .pause").live "click", (e) ->
    BH.Player.pause()
  $(".player .controls .next").live "click", (e) ->
    BH.Player.next()
