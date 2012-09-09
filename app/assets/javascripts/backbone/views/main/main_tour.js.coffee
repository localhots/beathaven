class BeatHaven.Views.MainTour extends Backbone.View
  template: HoganTemplates["backbone/templates/main/tour"]

  render: ->
    $(".fullscreen").show()
    $(@el).html(@template.render())
    this
