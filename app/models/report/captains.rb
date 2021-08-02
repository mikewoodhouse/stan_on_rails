class Report::Captains < Report
  def initialize(params)
    super
    @title = "Captains"
    @columns = [
      Field.new("name", "Name", "name"),
      Field.new("from_yr", "From", "year"),
      Field.new("to_yr", "To", "year"),
      Field.new("seasons", "Seasons", "number"),
      Field.new("matches", "Matches", "number"),
      Field.new("won", "Won", "number"),
      Field.new("pct_won", "Won %", "number", "pct"),
      Field.new("lost", "Lost", "number"),
      Field.new("drawn", "Drawn", "number"),
      Field.new("tied", "Tied", "number"),
      Field.new("nodecision", "N/D", "number"),
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
