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

  PERF_SQL = %{
  SELECT
    year
  , matches
  , innings
  , notout
  , highest || CASE WHEN highestnotout = 1 THEN '*' ELSE '' END high_score
  , runsscored
  , fours
  , sixes
  , overs
  , balls
  , maidens
  , wides
  , noballs
  , runs
  , wickets
  , fivewktinn
  , caught
  , stumped
  , fifties
  , hundreds
  , fives
  , caughtwkt
  , captain
  , keptwicket
  FROM performances
  WHERE player_id = :player_id
  UNION
  SELECT
    'TOTAL'
  , Sum(matches)
  , Sum(innings)
  , Sum(notout)
  , (SELECT MAX(highest) FROM performances WHERE player_id = :player_id) ||
    CASE (
        SELECT Max(highestnotout)
        FROM performances
        WHERE player_id = :player_id
        AND highest = (
            SELECT Max(highest)
            FROM performances
            WHERE player_id = :player_id)
    ) WHEN 1 THEN '*' ELSE '' END high_score
  , Sum(runsscored)
  , Sum(fours)
  , Sum(sixes)
  , Sum(overs)
  , Sum(balls)
  , Sum(maidens)
  , Sum(wides)
  , Sum(noballs)
  , Sum(runs)
  , Sum(wickets)
  , Sum(fivewktinn)
  , Sum(caught)
  , Sum(stumped)
  , Sum(fifties)
  , Sum(hundreds)
  , Sum(fives)
  , Sum(caughtwkt)
  , Sum(captain)
  , Sum(keptwicket)
  FROM performances
  WHERE player_id = :player_id
  }

  def show
    @player = Player.find_by_code(params[:code])
    @performances = Performance.find_by_sql [PERF_SQL, { :player_id => @player.id }]
  end

  def appearances
    min_matches = params[:min_matches] || 10
    min_matches = min_matches.to_i
    active_from_year = params[:active_from] || Date.today.year - 10
    active_from_year = active_from_year.to_i
    @players = Player.find_by_sql(ALL_PLAYER_SQL, [min_matches, active_from_year])
  end
end
