class Game < ApplicationRecord
  has_many :players
  has_many :rolls

  validates :name, presence: true
end
