class SeasonController < ApplicationController
  def index
    @seasons = Season.all
  end
end
