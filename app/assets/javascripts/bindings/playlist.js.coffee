$ ->
  $(".album-play").live "mouseup", (e) ->
    $(this).parents(".album").find(".tracks li:first .track-play").trigger("mouseup")
  $(".album-add").live "mouseup", (e) ->
    $(this).parents(".album").find(".tracks li .track-add").trigger("mouseup")
