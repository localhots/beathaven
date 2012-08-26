class BeatHaven.Views.ArtistShow extends Backbone.View
  template: HoganTemplates["backbone/templates/artists/show"]

  initialize: ->
    @model.on("change", @render, this)

  render: ->
    return this if typeof @model.attributes.id is "string"
    $(@el).html(@template.render(@model.toJSON()))
    this
