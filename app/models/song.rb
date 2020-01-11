class Song < ApplicationRecord
  belongs_to :album

  validates :name, presence: true
  validates_length_of :name, maximum: 100
end