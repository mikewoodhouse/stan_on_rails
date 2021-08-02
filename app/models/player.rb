class Player < ApplicationRecord
  def display_name
    tail = firstname || initial
    surname + (tail ? ", " + tail : "")
  end
end
