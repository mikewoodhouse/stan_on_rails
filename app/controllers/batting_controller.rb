require "batting_sql"

class BattingController < ApplicationController
  def hundred_plus
    @page_title = "Centuries"
    @hundreds = HundredPlus.includes(:player).all.order("score DESC")
  end

  def most_runs
    @page_title = "Career Runs"
    @run_makers = Player.find_by_sql TOTAL_RUNS_SQL
  end

  def averages
    @page_title = "Career Batting Averages"
    params[:min_innings] ||= 50
    min_innings = params[:min_innings].to_i
    @player_bat_aves = Player.find_by_sql [BAT_AVE_SQL, { :min_innings => min_innings }]
  end
end
