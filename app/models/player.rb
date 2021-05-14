class Player < ApplicationRecord
  has_many :performances
  has_many :hundred_plus

  def name()
    return surname + (firstname ? ", " + firstname :
             +(initial ? ", " + initial : ""))
  end
end
