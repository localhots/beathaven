class BeatHaven.Modules.ProtectedModel extends Backbone.Model

  fetch: (options) ->
    options = options ? _.clone(options) : {}
    model = this
    success = options.success
    options.success = (resp, status, xhr) ->
      if (!model.set(model.parse(resp, xhr), options)) return false;
      if (success) success(model, resp);
    };
    options.error = Backbone.wrapError(options.error, model, options);
    return (this.sync || Backbone.sync).call(this, 'read', this, options);
