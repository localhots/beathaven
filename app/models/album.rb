class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :tracks
  belongs_to :image # sick!

  scope :shown, lambda {
    self
      .where('"albums"."year" > ?', 0)
      .where(is_hidden: false)
      .includes(:tracks)
      # .group('"albums"."id"')
      # .having('count("tracks"."id") > ?', 0)
      # .order('"albums"."year" ASC')
  }

  attr_accessible :artist_id, :image, :rovi_id, :title, :year, :is_hidden, :tracks
  VA = "Various Artists"

  def pic_safe
    unless image.nil?
      image.sized(:extralarge)
    else
      "/api/albums/#{id}/picture"
    end
  end

  def pic_thumb
    pic_safe
  end

  def update_image
    self.image ||= Image.create
    update_attributes(image: self.image.load_album_pic(artist.nil? ? VA : artist.name, title))

    image
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
      tracks: robbie_album.tracks.map{ |robbie_track|
        track = Track.find_or_create_by_rovi_id(robbie_track.id)
        track.update_attributes(
          disc_id: robbie_track.disc_id,
          position: robbie_track.position,
          title: robbie_track.title,
          duration: robbie_track.duration,
          artists: robbie_track.artists.map{ |robbie_artist|
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
