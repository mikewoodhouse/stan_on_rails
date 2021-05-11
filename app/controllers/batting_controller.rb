class BattingController < ApplicationController
  def hundred_plus
    @hundreds = HundredPlus.includes(:player).all.order("score DESC")
  end
end
