class CaptainsReport < Report
  def initialize
    super
    @title = "Captains"
  end

  def columns
    [
      Field.new("name", "name", ""),
      Field.new("from_yr", "from_yr", ""),
      Field.new("to_yr", "to_yr", ""),
      Field.new("seasons", "seasons", ""),
      Field.new("matches", "matches", ""),
      Field.new("won", "won", ""),
      Field.new("pct_won", "pct_won", ""),
      Field.new("lost", "lost", ""),
      Field.new("drawn", "drawn", ""),
      Field.new("tied", "tied", ""),
      Field.new("nodecision", "nodecision", ""),
    ]
  end

  def sql
    %{
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
  end
end
