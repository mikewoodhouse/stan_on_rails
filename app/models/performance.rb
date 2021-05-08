class Performance < ApplicationRecord
  belongs_to :player, foreign_key: true, optional: true
end
