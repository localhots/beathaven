class BeatHaven.Models.VK extends Backbone.Model

  session_length: 3600 # seconds
  Music: null
  BITMASK: 8

  popup: ->
    alert(1)

  init: ->
    @Music = new VkMusic()
    BH.log "Initializing Vkontakte API ..."
    window.VK.init(apiId: VK_APP_ID)
    BH.VK.auth()
    # VK.Widgets.Like("vk-like", {type: "mini", height: 20, pageUrl: "http://beathaven.org/", text: "Like"})

  auth: (callback) ->
    BH.log "Requesting new Vkontakte session ..."
    window.VK.Auth.getLoginStatus (response) ->
      BH.VK.auth_info(response)
      callback() if callback?
      false
    , window.BH.VK.BITMASK
    false

  auth_info: (response) ->
    if typeof response isnt "undefined" and response.session?
      BH.User.set(vk_session: response.session)
      BH.User.auth()

      if response.session.expire?
        expire_in = response.session.expire * 1000 - new Date().getTime()
        # time is an illusion...
        expire_in = @session_length * 1000
        BH.log "Session will expire in #{Math.round(expire_in / 1000)} seconds"
        setTimeout ->
          BH.log "Session expired"
          BH.VK.auth()
        , expire_in + 1000
    else
      BH.log "Not authorized"


  set_favorites: ->
    window.VK.Api.call "audio.get", uid: BH.User.vk_id(), (response) ->
      BH.User.set_favorites(response.response)
