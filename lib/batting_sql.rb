TOTAL_RUNS_SQL = %{
  SELECT
    p.surname
  , p.initial
  , p.firstname
  , p.code
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
  , Max(b.highest) highest
  , Sum(runsscored) runsscored
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
