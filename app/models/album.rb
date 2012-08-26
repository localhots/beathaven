class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :tracks

  attr_accessible :artist_id, :pic, :rovi_id, :title, :year

  def pic_safe
    unless pic.nil?
      pic
    else
      "/api/albums/#{id}/picture"
    end
  end

  def load_pic
    info = BeatParser::Sources::Lastfm.album_info(artist.name, title)
    unless info[:pic].nil?
      update_attributes(pic: info[:pic])
      info[:pic]
    else
      "/assets/images/album-dummy.png"
    end
  end
end
