class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :tracks

  scope :shown, lambda {
    self
      .where('"albums"."year" > ?', 0)
      .where(is_hidden: false)
      .joins(:tracks)
      .group('"albums"."id"')
      .having('count("tracks"."id") > ?', 0)
      .order('"albums"."year" ASC')
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
    info = BeatParser::Sources::Lastfm.album_info((artist.nil? ? VA : artist.name), title)
    unless info[:pic].nil?
      update_attributes(pic: info[:pic])
      info[:pic]
    else
      "/assets/images/album-dummy.png"
    end
  end

  def dump_json
    Jbuilder.encode do |j|
      j.album_title title
      j.album_year year
      j.album_pic pic_safe
      j.album_tracks tracks.to_a do |j, track|
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
          j.album title
          j.album_pic pic_safe
        end
      end
    end


  end

  def import
    return unless rovi_id?

    Album.import(Robbie::Album.find(rovi_id))
  end

  class << self
    def import(rovi_album)
      data = BeatParser::Aggregator.new.album(rovi_album.id)
      album = Album.find_or_create_by_rovi_id(data[:id])
      album.update_attributes(
        title: data[:title],
        year: data[:year].to_i
      )
      data[:tracks].each do |track_meta|
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
      album
    end
  end
end
