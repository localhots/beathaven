class Track < ActiveRecord::Base
  belongs_to :album
  has_many :performers
  has_many :artists, through: :performers

  attr_accessible :album_id, :disc_id, :duration, :position, :rovi_id, :title
  scope :with_artists, lambda{
    includes(:artists)
  }

  def length
    return if duration.nil?
    length = duration.divmod(60).map(&:to_s)
    length[1] = "0" << length[1] if length[1].length == 1
    length.join(":")
  end
end
