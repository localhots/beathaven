json.artist_title @artist.name
json.artist_pic @artist.pic
json.artist_bio @artist.bio
json.artist_loaded @artist.loaded?
json.artist_url @artist.url
json.artist_albums @artist.albums.shown.to_a do |json, album|
  json.album_title album.title
  json.album_year album.year
  json.album_pic album.pic_safe
  json.album_tracks album.tracks.to_a do |json, track|
    json.track_id track.id
    json.track_title track.title
    json.track_length track.length
    json.track_disc track.disc_id
    json.track_position track.position
    json.meta do |json|
      json.id track.id
      json.title track.title
      json.duration track.duration
      json.length track.length
      json.artists track.artists.map(&:name)
      json.album album.title
      json.album_pic album.pic_safe
    end
  end
end
