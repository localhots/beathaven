json.album_title @album.title
json.album_year @album.year
json.album_pic @album.pic_safe
json.album_tracks @album.tracks.to_a do |json, track|
  json.track_id track.id
  json.track_title track.title
  json.track_duration track.duration
  json.track_artists track.artists do |json, artist|
    json.artist_title artist.name
    json.artist_url artist.url
  end
  json.track_disc track.disc_id
  json.track_position track.position
  json.track_length track.length
  json.meta do |json|
    json.id track.id
    json.title track.title
    json.duration track.duration
    json.length track.length
    json.artists track.artists.map(&:name)
    json.album title
    json.album_pic pic_safe
  end
end
