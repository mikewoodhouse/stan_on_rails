require "batting_sql"

class BattingController < ApplicationController
  def hundred_plus
    @hundreds = HundredPlus.includes(:player).all.order("score DESC")
  end

  def most_runs
    @run_makers = Player.find_by_sql TOTAL_RUNS_SQL
  end

  def averages
    min_innings = params[:min_innings].to_i
    @player_bat_aves = Player.find_by_sql [BAT_AVE_SQL, { :min_innings => min_innings }]
  end
end
