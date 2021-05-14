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
  }

  def show
    @player = Player.includes(:performances).find_by_code(params[:code])
  end

  def appearances
    min_matches = params[:min_matches] || 10
    min_matches = min_matches.to_i
    @players = Player.find_by_sql(ALL_PLAYER_SQL, [min_matches])
  end
end
