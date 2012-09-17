class Image < ActiveRecord::Base
  attr_accessible :sizes
  serialize :sizes

  def sized(kind)
    sizes[kind]
  end

  def load_artist_pics(artist_name)
    sizes = begin
      response = LastFM::Artist.get_info(artist: artist_name)
      Hash[response["artist"]["image"].map{ |img| [img["size"], img["#text"]] }].symbolize_keys
    rescue => e
      {}
    end

    update_attributes(sizes: sizes)
    self
  end

  def load_album_pic(artist_name, album_name)
    sizes = begin
      response = LastFM::Album.get_info(artist: artist_name, album: album_name)
      Hash[response["album"]["image"].map{ |img| [img["size"], img["#text"]] }].symbolize_keys
    rescue => e
      {}
    end

    update_attributes(sizes: sizes)
    self
  end
end
