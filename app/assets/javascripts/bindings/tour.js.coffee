window.tour_auth = ->
  VK.Auth.login (response) ->
    BH.VK.auth_info(response)
    if response.session?
      $(".tour .step").hide()
      $(".tour .step-2").show()
      $(".tour .step-2 .your-name-here").text("#{response.session.user.first_name}")
      $(".tour .step-2 .your-favorite-artist-here").text("Foo Fighters")
      Backbone.history.navigate("/artist/Foo+Fighters", true)
    else
      $(".tour .step").hide()
      $(".tour .step-1a").show()
  , BH.VK.BITMASK

$ ->
  $(".tour .step-1 a").live "click", (e) ->
    e.preventDefault()
    tour_auth()

  $(".tour .step-1a a.again").live "click", (e) ->
    e.preventDefault()
    tour_auth()

  $(".tour .step-2 a").live "click", (e) ->
    e.preventDefault()
    $(".tour").hide()
    $(".fullscreen").css(opacity: .3)
    $(".navbar .search-query").popover(
      placement: "bottom"
      title: $(".tour .step-3 .title")
      content: $(".tour .step-3 .content").html()
      html: true
      trigger: "manual"
    ).popover("show")

  $("a.tour-step-3").live "click", (e) ->
    e.preventDefault()
    $(".navbar .search-query").popover("hide")
    $(".artist-page .tracks li:first .track-play").popover(
      placement: "top"
      title: $(".tour .step-4 .title")
      content: $(".tour .step-4 .content").html()
      html: true
      trigger: "manual"
    ).popover("show")

  $("a.tour-step-4").live "click", (e) ->
    e.preventDefault()
    $(".artist-page .tracks li:first .track-play").popover("hide").trigger("click")
    $(".player .progress-bar").popover(
      placement: "bottom"
      title: $(".tour .step-5 .title")
      content: $(".tour .step-5 .content").html()
      html: true
      trigger: "manual"
    ).popover("show")

  $("a.tour-step-5").live "click", (e) ->
    e.preventDefault()
    $(".player .progress-bar").popover("hide")
    $(".player .controls").popover(
      placement: "bottom"
      title: $(".tour .step-6 .title")
      content: $(".tour .step-6 .content").html()
      html: true
      trigger: "manual"
    ).popover("show")

  $("a.tour-step-6").live "click", (e) ->
    e.preventDefault()
    $(".player .controls").popover("hide")
    $(".popover").remove()
    $(".fullscreen").hide()


