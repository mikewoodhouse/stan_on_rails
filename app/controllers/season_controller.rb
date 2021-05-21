class SeasonController < ApplicationController
  def index
    @seasons = Season.order("year DESC").all
  end
end
