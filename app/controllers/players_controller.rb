class PlayersController < ApplicationController
  def index
    @players = Player.includes(:performances).all
  end

  def appearances
    @players = Player.includes(:performances).all.sort_by(&:appearances).reverse
  end
end
