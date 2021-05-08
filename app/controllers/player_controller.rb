class PlayerController < ApplicationController
  def show
    @player = Player.includes(:performances).find_by_code(params[:code])
  end
end
