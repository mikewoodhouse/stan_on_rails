class SeasonRecord < ApplicationRecord
  def highest_match
    "#{highest} for #{highestwkts}, #{highestopps}, #{highestdate}"
  end

  def lowest_match
    "#{lowest} for #{lowestwkts}, #{lowestopps}, #{lowestdate}"
  end
end
