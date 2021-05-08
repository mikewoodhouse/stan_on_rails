class Performance < ApplicationRecord
  belongs_to :player, foreign_key: true, optional: true

  def high_score
    highest.to_s + (highestnotout ? "*" : "")
  end

  def bat_avg
    return innings > notout ? (runsscored.to_f / (innings - notout)).round(2) : ""
  end

  def bowl_avg
    return wickets > 0 ? (runs.to_f / wickets).round(2) : ""
  end

  def overs_and_balls
    "#{overs}.#{balls}"
  end
end
