class SeasonController < ApplicationController
  def index
    @seasons = Season.order("year DESC").all
  end

  def averages
    @year = params[:year]
    rows = Performance.find_by_sql [
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
    @perfs = {
      included: rows.select { |perf| perf.innings - perf.notout >= 5 }.sort_by { |perf| -perf.bat_avg },
      also: rows.select { |perf| perf.innings - perf.notout < 5 }.sort_by { |perf| perf.surname },
    }
  end
end
