class Report::Runs < Report
  def initialize(params)
    super
    @title = "Career Runs"
    @columns = [
      Field.new("name", "Name", "name"),
      Field.new("from_yr", "From", "year"),
      Field.new("to_yr", "To", "year"),
      Field.new("runs", "Runs", "number"),
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
      lkup.name
    , Min(b.year) from_yr
    , Max(b.year) to_yr
    , Sum(b.runsscored) runs
    FROM
      players p
        INNER JOIN
          performances b ON b.player_id = p.id
        INNER JOIN
          player_lookup lkup ON lkup.id = p.id
    GROUP BY
      lkup.name
    ORDER BY runs DESC
    }
  end
end
