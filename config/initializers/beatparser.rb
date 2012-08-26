File.open("#{Rails.root}/config/api_keys.yml") do |file|
  config = YAML.load(file.read)

  LastFM.api_key = config["lastfm"]["api_key"]
  LastFM.secret = config["lastfm"]["api_secret"]
  LastFM.client_name = config["lastfm"]["client_name"]

  Robbie.setup(
    api_key: config["rovi"]["api_key"],
    api_secret: config["rovi"]["api_secret"]
  )
  Robbie.enable_cache
end
