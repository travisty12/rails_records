class Artist < ApplicationRecord
  scope :search, -> (name) { where("lower(name) like ?", "%#{name.downcase}%") }
  scope :sort_by_method, -> (method) { order("#{method[0]} #{method[1]}")}
  scope :page, -> (page) { (offset("#{(page.to_i - 1) * 10}").limit(10)) }
  has_many :album_artists
  has_many :albums, :through => :album_artists

  validates :name, presence: true
  validates_length_of :name, maximum: 100
  before_save(:titleize_artist)

  private
    def titleize_artist
      self.name = self.name.titleize
    end
end