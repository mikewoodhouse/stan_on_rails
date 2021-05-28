require "bowling_sql"

class BowlingController < ApplicationController
  def averages
    @page_title = "Career Averages"
    min_wickets = params[:min_wickets] || 10
    @player_bowl_aves = Player.find_by_sql [BOWL_AVE_SQL, { :min_wickets => min_wickets.to_i }]
  end

  def wickets
    @page_title = "Career Wickets"
    @wicket_takers = Player.find_by_sql CAREER_WICKETS_SQL
  end

  def five_for
    @page_title = "Best Bowling: 5 or more"
    @five_fors = Player.find_by_sql FIVE_FOR_SQL
  end
end
