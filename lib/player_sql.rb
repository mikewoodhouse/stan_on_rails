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
  ORDER BY p.surname, p.firstname, p.initial
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

CAPTAINS_SQL = %{
  WITH player_lookup AS
  (
   SELECT id
   , surname || ', ' || COALESCE(firstname, initial, '') AS name
   FROM players
  )
  SELECT
    p.name
  , p.id
  , Min(c.year) from_yr
  , Max(c.year) to_yr
  , Count(*) seasons
  , Sum(c.matches) matches
  , Sum(c.won) won
  , Cast(Sum(c.won) AS REAL) / Sum(c.matches) * 100.0 pct_won
  , Sum(c.lost) lost
  , Sum(c.drawn) drawn
  , Sum(c.tied) tied
  , Sum(c.nodecision) nodecision
  FROM player_lookup p
    JOIN captains c
      ON c.player_id = p.id
  GROUP BY
    p.id
  , p.name
  ORDER BY
    matches DESC
}
