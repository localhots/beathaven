class BeatHaven.Models.User extends Backbone.Model

  auth: ->
    BH.log "Authenticating user ..."
    this.query "/api/session/auth", { user: @.get("vk_session")["user"] }, (response) ->
      if response.error?
        # report error
      else
        BH.User.set(JSON.parse(response.user))
        if response.is_newbie
          BH.log "Requesting user tracks from Vkontakte ..."
          # BH.VK.set_favorites()

  query: (path, params, callback) ->
    query_params = $.extend {}, @auth_params(), params
    query_params.authenticity_token = $('meta[name="csrf-token"]').attr("content")
    $.get path, query_params, callback
    false

  auth_params: ->
    params = @.get("vk_session")
    vk_auth:
      expire: params["expire"]
      mid: params["mid"]
      secret: params["secret"]
      sid: params["sid"]
      sig: params["sig"]

  set_favorites: (tracks) ->
    BH.log tracks
    BH.log "Sending your Vkontakte media collection to BeatHaven ..."
    this.query "/user/set_first_favorites", tracks: tracks, (response) ->
      if response.error?
        BH.log "Got error: #{response.error}"
      else
        BH.log "We believe your favorite artists are #{response.join(', ')}"
