BOWL_AVE_SQL = %{
  SELECT
    p.surname
  , p.initial
  , p.firstname
  , p.code
  , Sum(b.overs) overs
  , Sum(b.balls) balls
  , Sum(b.maidens) maidens
  , Sum(b.runs) runs
  , Sum(b.wickets) wickets
  , Cast(Sum(b.runs) AS REAL) / Sum(b.wickets) bowlave
  , (Sum(b.overs) * 6 + Sum(b.balls)) / Cast(Sum(b.wickets) AS REAL) strike_rate
  , Cast(Sum(b.runs) AS REAL) * 6 / (Sum(b.overs) * 6 + Sum(b.balls)) economy
  , (SELECT Count(*) FROM best_bowlings bb WHERE bb.code = b.code) five_fors
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
    Sum(b.wickets) >= :min_wickets
  ORDER BY bowlave ASC
}
