class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :tracks

  scope :shown, lambda {
    self
      .where('"albums"."year" > ?', 0)
      .where(is_hidden: false)
      .includes(:tracks)
      # .group('"albums"."id"')
      # .having('count("tracks"."id") > ?', 0)
      # .order('"albums"."year" ASC')
  }

  attr_accessible :artist_id, :pic, :rovi_id, :title, :year, :is_hidden
  VA = "Various Artists"

  def pic_safe
    unless pic.nil?
      pic
    else
      "/api/albums/#{id}/picture"
    end
  end

  def load_pic
    info = begin
      response = LastFM::Album.get_info(artist: (artist.nil? ? VA : artist.name), album: title)
      { pic: response["album"]["image"][3]["#text"] }
    rescue => e
      { pic: nil }
    end

    unless info[:pic].nil?
      update_attributes(pic: info[:pic])
      info[:pic]
    else
      "/assets/images/album-dummy.png"
    end
  end

  def url
    "/album/#{id}"
  end

  def import
    return unless rovi_id?

    robbie_album = Robbie::Album.find(rovi_id)
    return if robbie_album.nil?

    update_attributes(
      title: robbie_album.title,
      year: robbie_album.year,
      tracks: robbie_album.tracks.each { |robbie_track|
        track = Track.find_or_create_by_rovi_id(robbie_track.id)
        track.update_attributes(
          disc_id: robbie_track.disc_id,
          position: robbie_track.position,
          title: robbie_track.title,
          duration: robbie_track.duration,
          artists: robbie_track.artists.map { |robbie_artist|
            track_artist = Artist.find_or_create_by_rovi_id(robbie_artist.id)
            track_artist.update_attributes(
              name: robbie_artist.name
            )
            track_artist
          }
        )
        track
      }
    )

    self
  end

end
