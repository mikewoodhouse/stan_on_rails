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
end
