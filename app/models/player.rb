class Player < ApplicationRecord
  def name()
    return "#{self.surname}, #{self.firstname}" if self.firstname
    return "#{self.surname}, #{self.initial}" if self.initial
    return self.surname
  end
end
