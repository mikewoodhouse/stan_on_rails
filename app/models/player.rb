class Player < ApplicationRecord
  has_many :performances

  def name()
    return surname + (firstname ? ", " + firstname :
             +(initial ? ", " + initial : ""))
  end

  def seasons
    @season_range ||= { from: performances.map(&:year).min, to: performances.map(&:year).max }
  end
end
