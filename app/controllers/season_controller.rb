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
    @bat_perfs = {
      included: rows.select { |perf| perf.innings - perf.notout >= 5 }.sort_by { |perf| -perf.bat_avg },
      also: rows.select { |perf| perf.innings - perf.notout < 5 }.sort_by { |perf| perf.surname },
    }
    @bowl_perfs = {
      included: rows.select { |perf| perf.wickets >= 10 }.sort_by { |perf| perf.bowl_avg },
      also: rows.select { |perf| perf.wickets < 10 && perf.overs + perf.balls > 0 }.sort_by { |perf| perf.surname },
    }
  end
end
