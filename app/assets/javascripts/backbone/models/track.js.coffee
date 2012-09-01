class BeatHaven.Models.Track extends Backbone.Model

  play: ->
    if @.get("sm_obj")?
      this.start()
    else
      this.find_and_start()

  start: ->
    BH.Player.update_title(
      artists: @.get("artists")
      track: @.get("title")
    )
    unless @.get("sm_obj")?
      this.add_to_library(autoload: true, autoplay: false)
    BH.Player.play(this)
    $(".artist-page .tracks li[data-id]").removeClass("now-playing")
    this.node().addClass("now-playing")

  find_and_start: ->
    self = this
    BH.VK.Music.search @.get("artists")[0], @.get("title"), @.get("length"), (url) ->
      self.set(url: url)
      self.start()

  add_to_library: (params) ->
    obj = soundManager.createSound
      id: @.get("id")
      url: @.get("url")
      autoLoad: params.autoload
      autoPlay: params.autoplay
      whileloading: ->
        BH.Player.update_buffer_bar(this)
      whileplaying: ->
        BH.Player.update_progress_bar(this)
      onfinish: ->
        BH.Player.next()
      ondataerror: ->
        BH.Player.next()
    @.set("sm_obj", obj)

  node: ->
    $(".artist-page .tracks li[data-id='#{@.get("id")}']")
