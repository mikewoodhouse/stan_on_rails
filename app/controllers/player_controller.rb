class PlayerController < ApplicationController
  def show
    @player = Player.find_by_code(params[:code])
  end
end
