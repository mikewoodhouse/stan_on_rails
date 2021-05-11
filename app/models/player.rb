class Player < ApplicationRecord
  has_many :performances
  has_many :hundred_plus

  def name()
    return surname + (firstname ? ", " + firstname :
             +(initial ? ", " + initial : ""))
  end

  def seasons
    @season_range ||= { from: performances.map(&:year).min, to: performances.map(&:year).max }
  end

  def appearances
    @apps ||= performances.sum(&:matches)
  end
end
