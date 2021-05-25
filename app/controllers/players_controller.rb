require "player_sql"

class PlayersController < ApplicationController
  def show
    @page_title = "Player Season History"
    @player = Player.find_by_code(params[:code])
    @performances = Performance.find_by_sql [PERF_SQL, { :player_id => @player.id }]
  end

  def appearances
    @page_title = "Career Appearances"
    min_matches = params[:min_matches] || 10
    min_matches = min_matches.to_i
    active_from_year = params[:active_from] || Date.today.year - 10
    active_from_year = active_from_year.to_i
    @players = Player.find_by_sql(ALL_PLAYER_SQL, [min_matches, active_from_year])
  end
end
