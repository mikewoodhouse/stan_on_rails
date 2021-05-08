class Performance < ApplicationRecord
  belongs_to :player, foreign_key: true, optional: true

  def high_score
    self.highest.to_s + (self.highestnotout ? "*" : "")
  end

  def bat_avg
    0.0
  end

  def bowl_avg
    99.99
  end

  def overs_and_balls
    "#{self.overs}.#{self.balls}"
  end
end
