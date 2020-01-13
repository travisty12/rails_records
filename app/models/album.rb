class Album < ApplicationRecord
  scope :jazz, -> { where(genre: "Jazz") }
  scope :search, -> (name) { where("lower(name) like ?", "%#{name.downcase}%") }
  scope :sort_by_method, -> (method) { order("#{method[0]} #{method[1]}")}
  scope :page, -> (page) { (offset("#{(page.to_i - 1) * 10}").limit(10)) }
  scope :most_songs, -> {(
    select("albums.id, albums.name, albums.genre, count(songs.id) as songs_count")
    .joins(:songs)
    .group("albums.id")
    .order("songs_count DESC")
    .limit(10)
  )}
  has_many :album_artists
  has_many :artists, :through => :album_artists
  has_many :songs, dependent: :destroy

  validates :name, presence: true
  validates_length_of :name, maximum: 100
  before_save(:titleize_album)

  private
    def titleize_album
      self.name = self.name.titleize
    end
end