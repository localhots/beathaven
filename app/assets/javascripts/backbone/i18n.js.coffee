class BeatHaven.Modules.I18n
  fallback_locale: "ru"

  init: ->
    this.translate_app()

  locale: ->
    return @fallback_locale unless BH.User? and BH.User.locale?
    return @fallback_locale unless BH.User.locale in ["en"]
    BH.User.locale

  translate_app: ->
    lang_code = this.locale()
    self = this
    $("*[data-translate-contents], *[data-translate-title], *[data-translate-placeholder]").each ->
      if $(this).data("translate-contents")?
        type = "contents"
      else if $(this).data("translate-title")?
        type = "title"
      else if $(this).data("translate-placeholder")?
        type = "placeholder"
      lstr = $(this).data("translate-#{type}")
      val = self.t(lstr, lang_code)

      switch type
        when "contents"
          $(this).html(val)
        when "title"
          $(this).attr("title", val)
        when "placeholder"
          $(this).attr("placeholder", val)

  t: (lstr, lang_code) ->
    unless lang_code?
      lang_code = this.locale()
    eval "BH.locales.#{lang_code}['#{lstr.split(".").join("']['")}']"
