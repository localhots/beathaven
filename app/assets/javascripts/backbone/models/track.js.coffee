class BeatHaven.Models.Track extends Backbone.Model

  play: ->
    BeatHaven.player.update_title(
      artists: @.get("artists")
      track: @.get("title")
    )
