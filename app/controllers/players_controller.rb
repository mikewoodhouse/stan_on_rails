class PlayersController < ApplicationController
  def index
    @players = Player.includes(:performances).all
  end

  def show
    @player = Player.includes(:performances).find_by_code(params[:code])
  end

  def appearances
    @players = Player.includes(:performances).all.sort_by(&:appearances).reverse
  end
end
