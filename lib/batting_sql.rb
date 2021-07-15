TOTAL_RUNS_SQL = %{
  SELECT
    p.surname
  , p.initial
  , p.firstname
  , p.code
  , Min(b.year) from_yr
  , Max(b.year) to_yr
  , Sum(b.runsscored) runs
  FROM
    players p
      INNER JOIN
        performances b ON b.player_id = p.id
  GROUP BY
    p.surname
  , p.initial
  , p.firstname
  , p.code
  ORDER BY runs DESC
}

BAT_AVE_SQL = %{
  SELECT
    p.surname
  , p.initial
  , p.firstname
  , p.code
  , Sum(b.matches) matches
  , Sum(b.innings) innings
  , Sum(b.notout) notout
  , (SELECT Max(pf.highest) FROM performances pf WHERE pf.player_id = p.id) ||
    CASE (
        SELECT Max(f.highestnotout)
        FROM performances f
        WHERE f.player_id = p.id
        AND f.highest = (
            SELECT Max(ff.highest)
            FROM performances ff
            WHERE ff.player_id = p.id)
    ) WHEN 1 THEN '*' ELSE '' END high_score
  , Sum(b.runsscored) runsscored
  , CASE Sum(b.innings)
      WHEN Sum(b.notout) THEN 0.0
      ELSE Sum(Cast(b.runsscored AS REAL)) / (Sum(b.innings) - Sum(b.notout))
    END batave
  , Sum(b.fours) fours
  , Sum(b.sixes) sixes
  , Sum(b.fifties) fifties
  , Sum(b.hundreds) hundreds
  FROM
    players p
      INNER JOIN
        performances b ON b.player_id = p.id
  GROUP BY
    p.surname
  , p.initial
  , p.firstname
  , p.code
  HAVING
    Sum(b.innings) - Sum(b.notout) >= :min_innings
  ORDER BY batave DESC
}
