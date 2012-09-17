class ArtistInfo < ActiveRecord::Base
  belongs_to :artist
  attr_accessible :artist_id, :bio, :lang

  def import
    begin
      info = LastFM::Artist.get_info(artist: artist.name, lang: lang)
      update_attributes(bio: info["artist"]["bio"]["summary"])
      true
    rescue => e
      false
    end
  end
end
