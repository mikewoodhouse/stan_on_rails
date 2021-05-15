class PlayersController < ApplicationController
  ALL_PLAYER_SQL = %{
  SELECT
    p.id
  , p.code
  , p.surname
  , p.initial
  , p.firstname
  , min(f.year) from_yr
  , max(f.year) to_yr
  , Sum(f.matches) appearances
  FROM players p
    INNER JOIN performances f
    ON f.player_id = p.id
  GROUP BY
    p.id
  , p.code
  , p.surname
  , p.initial
  , p.firstname
  HAVING Sum(f.matches) >= ?
  AND Max(f.year) >= ?
  }

  def show
    @player = Player.find_by_code(params[:code])
    @performances = @player.performances
    append_career_summary
  end

  def appearances
    min_matches = params[:min_matches] || 10
    min_matches = min_matches.to_i
    active_from_year = params[:active_from] || Date.today.year - 10
    active_from_year = active_from_year.to_i
    @players = Player.find_by_sql(ALL_PLAYER_SQL, [min_matches, active_from_year])
  end

  def append_career_summary
    highest, notout = -1, false
    @performances.each do |perf|
      if perf.highest > highest || (perf.highest == highest && perf.highestnotout)
        highest, notout = perf.highest, perf.highestnotout
      end
    end

    @total = {
      matches: @performances.sum(&:matches),
      innings: @performances.sum(&:innings),
      notout: @performances.sum(&:notout),
      high_score: highest.to_s + (notout ? "*" : ""),
      runsscored: @performances.sum(&:runsscored),
      fifties: @performances.sum(&:fifties),
      hundreds: @performances.sum(&:hundreds),
      fours: @performances.sum(&:fours),
      sixes: @performances.sum(&:sixes),
      maidens: @performances.sum(&:maidens),
      runs: @performances.sum(&:runs),
      wickets: @performances.sum(&:wickets),
      fivewktinn: @performances.sum(&:fivewktinn),
      caught: @performances.sum(&:caught),
      stumped: @performances.sum(&:stumped),
      caughtwkt: @performances.sum(&:caughtwkt),
      captain: @performances.sum(&:captain),
      keptwicket: @performances.sum(&:keptwicket),
      overs: @performances.sum(&:overs),
      balls: @performances.sum(&:balls),
    }
    @total[:bat_avg] = @total[:innings] > @total[:notout] ? @total[:runsscored] / (@total[:innings] - @total[:notout]) : ""
    @total[:bowl_avg] = @total[:wickets] > 0 ? @total[:runs] / @total[:wickets] : ""
    add_overs, balls = @total[:balls].divmod(6)
    @total[:overs_and_balls] = "#{@total[:overs] + add_overs}.#{balls}"
  end
end
