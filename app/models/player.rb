class Player < ApplicationRecord
  has_many :performances
  has_many :hundred_plus
end
