class Player < ApplicationRecord
  has_many :performances
  has_many :hundred_plus

  def name()
    return player_name(self)
  end
end
