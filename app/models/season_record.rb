class SeasonRecord < ApplicationRecord
  def highest_match
    "#{highest} for #{highestwkts}, #{highestopps}, #{to_mmmdd(highestdate)}"
  end

  def lowest_match
    "#{lowest} for #{lowestwkts}, #{lowestopps}, #{to_mmmdd(lowestdate)}"
  end

  def to_mmmdd(dt)
    dt ? dt.strftime("%b %e") : nil
  end
end
