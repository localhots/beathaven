File.open("#{Rails.root}/config/api_keys.yml") do |file|
  config = YAML.load(file.read)
  BeatHaven::Application.config.api_accounts = config

  LastFM.api_key = config["lastfm"]["api_key"]
  LastFM.secret = config["lastfm"]["api_secret"]
  LastFM.client_name = config["lastfm"]["client_name"]

  Robbie.setup(config["rovi"].symbolize_keys)
  Robbie.enable_cache
end
