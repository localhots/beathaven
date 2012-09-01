$ ->
  $(".auth a").bind "mouseup", (e) ->
    e.preventDefault()
    if BeatHaven.authenticated
      alert("auth ok!!!!!")
    else
      BeatHaven.VK.popup()
