class SeasonController < ApplicationController
  def index
    @seasons = Season.order("year DESC").all
  end

  def averages
    @year = params[:year]
    @perfs = Performance.find_by_sql [
      %{
        SELECT
          p.surname
        , p.firstname
        , p.initial
        , p.code
        , f.*
        FROM performances f
          JOIN players p
          ON p.id = f.player_id
        WHERE f.year = :year
      },
      { :year => @year },
    ]
  end
end
