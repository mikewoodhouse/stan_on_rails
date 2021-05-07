class Player < ApplicationRecord
  def name()
    return self.surname + (self.firstname ? ", " + self.firstname :
             +(self.initial ? ", " + self.initial : ""))
  end
end
