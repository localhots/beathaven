class Performer < ActiveRecord::Base
  belongs_to :artist
  belongs_to :track

  attr_accessible :artist_id, :track_id
end
