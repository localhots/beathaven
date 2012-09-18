class Artist < ActiveRecord::Base
  has_many :albums
  has_many :performers
  has_many :tracks, through: :performers
  has_many :artist_genres
  has_many :artist_infos
  has_many :genres, through: :artist_genres
  belongs_to :image # sick!

  attr_accessible :is_group, :name, :rovi_id, :albums, :genres, :image, :artist_infos

  scope :discography, lambda {
    includes(:albums).includes(:tracks)
  }

  def loaded?
    true
  end

  def update_image
    self.image ||= Image.create
    update_attributes(image: self.image.load_artist_pics(name))

    image
  end

  def update_info
    %w[ ru en ].each do |lang|
      ArtistInfo.find_or_create_by_artist_id_and_lang(id, lang).import
    end
  end

  def bio(lang = "en")
    artist_infos.where(lang: lang.to_s).first.bio rescue ""
  end

  def url
    "/artist/#{name.gsub(/\s/, "+")}" rescue ""
  end

  def import
    return unless rovi_id?

    robbie_artist = Robbie::Artist.find(rovi_id)
    return if robbie_artist.nil?

    update_attributes(
      name: robbie_artist.name,
      is_group: robbie_artist.is_group,
      pic: nil,
      bio: nil,
      albums: robbie_artist.albums.map{ |robbie_album|
        Album.find_or_create_by_rovi_id(robbie_album.id).import
      },
      genres: robbie_artist.genres.map{ |robbie_genre|
        genre = Genre.find_or_create_by_rovi_id(robbie_genre.id)
        genre.update_attributes(
          name: robbie_genre.name
        )
        genre
      }
    )
    update_info
    update_image

    self
  end

  class << self
    def with_name(name)
      # DB lookup
      artist = where(name: name).discography.first
      return artist unless artist.nil?

      # Rovi correction
      rovi_artist = Robbie::Artist.find_by_name(name)
      return artist if rovi_artist && artist = find_by_rovi_id(rovi_artist.id)

      # Parsing artist if ok
      Artist.create(rovi_id: robbie_artist.id).import
    end
  end
end
