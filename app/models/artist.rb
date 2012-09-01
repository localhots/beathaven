class Artist < ActiveRecord::Base
  has_many :albums
  has_many :performers
  has_many :tracks, through: :performers
  has_many :genres, through: :artist_genres

  attr_accessible :bio, :is_group, :name, :pic, :rovi_id

  def loaded?
    pic? && bio?
  end

  def url
    "/artist/#{name.gsub(/\s/, "+")}"
  end

  def dump_json
    Jbuilder.encode do |j|
      j.artist_title name
      j.artist_pic pic
      j.artist_bio bio
      j.artist_loaded loaded?
      j.artist_url url
      j.artist_albums albums.shown.to_a do |j, album|
        j.album_title album.title
        j.album_year album.year
        j.album_pic album.pic_safe
        j.album_tracks album.tracks.to_a do |j, track|
          j.track_id track.id
          j.track_title track.title
          j.track_duration track.duration
          j.track_disc track.disc_id
          j.track_position track.position
          j.meta do |j|
            j.id track.id
            j.title track.title
            j.duration track.duration
            j.length track.length
            j.artists track.artists.map(&:name)
            j.album album.title
            j.album_pic album.pic_safe
          end
        end
      end
    end
  end

  def import
    return unless rovi_id?

    Artist.import(Robbie::Artist.find(rovi_id))
  end

  class << self
    def with_name(name)
      # DB lookup
      artist = find_by_name(name)
      return artist unless artist.nil?

      # Rovi correction
      rovi_artist = Robbie::Artist.find_by_name(name)
      return artist if rovi_artist && artist = find_by_rovi_id(rovi_artist.id)

      # Parsing artist if ok
      import(rovi_artist) if rovi_artist
    end

    def import(rovi_artist)
      data = BeatParser::Aggregator.new.artist(rovi_artist.id)
      artist = Artist.find_or_create_by_rovi_id(data[:id])
      artist.update_attributes(
        name: data[:name],
        is_group: data[:is_group],
        pic: data[:pic],
        bio: data[:bio]
      )
      data[:albums].each do |album_meta|
        album = Album.find_or_create_by_rovi_id(album_meta[:id])
        album.update_attributes(
          artist_id: artist.id,
          title: album_meta[:title],
          year: album_meta[:year].to_i
        )
        album_meta[:tracks].each do |track_meta|
          track = Track.find_or_create_by_rovi_id(track_meta[:id])
          track.update_attributes(
            album_id: album.id,
            disc_id: track_meta[:disc_id],
            position: track_meta[:position],
            title: track_meta[:title],
            duration: track_meta[:duration]
          )
          track_meta[:artists].each do |performer|
            performer_artist = Artist.find_or_create_by_rovi_id(performer[:id])
            performer_artist.update_attributes(
              name: performer[:name]
            )
            Performer.find_or_create_by_artist_id_and_track_id(performer_artist.id, track.id)
          end
        end
      end
      data[:genres].each do |genre_meta|
        genre = Genre.find_or_create_by_rovi_id(genre_meta[:id])
        genre.update_attributes(
          name: genre_meta[:name]
        )
        ArtistGenre.find_or_create_by_artist_id_and_genre_id(artist.id, genre.id)
      end
      artist
    end
  end
end
