class Player < ApplicationRecord
  has_many :performances

  def name()
    return self.surname + (self.firstname ? ", " + self.firstname :
             +(self.initial ? ", " + self.initial : ""))
  end
end
