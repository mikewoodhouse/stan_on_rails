class HundredPlus < ApplicationRecord
  belongs_to :player

  def runs
    "#{score}#{notout ? "*" : ""}"
  end
end
