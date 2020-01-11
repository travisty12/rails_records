class Album < ApplicationRecord
  has_many :songs, dependent: :destroy

  validates :name, presence: true
  validates_length_of :name, maximum: 100
end