class BattingController < ApplicationController
  def hundred_plus
    @hundreds = HundredPlus.includes(:player).all.order("score DESC")
  end

  def most_runs
    @run_makers = Player.find_by_sql(
      %{
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
    )
  end

  def averages
    @player_bat_aves = Player.find_by_sql(
      %{
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
          Sum(b.innings) - Sum(b.notout) >= 10
        ORDER BY batave DESC
      }
    )
  end
end
