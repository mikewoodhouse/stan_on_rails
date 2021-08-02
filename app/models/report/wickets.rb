class Report::Wickets < Report
  def initialize(params)
    super params
    @title = "Career Wickets"
    @columns = [
      Field.new("name", "Name", "name"),
      Field.new("wickets", "Wickets", "number"),
    ]
  end

  def sql
    %{
    WITH player_lookup AS
    (
        SELECT id
        , surname || ', ' || COALESCE(firstname, initial, '') AS name
        FROM players
    )    SELECT
      p.id
    , lkup.name
    , Sum(b.wickets) wickets
    FROM
      players p
        INNER JOIN
          performances b ON b.player_id = p.id
        INNER JOIN
          player_lookup lkup ON lkup.id = p.id
    GROUP BY
      p.id
    , lkup.name
    HAVING Sum(b.wickets) > 0
    ORDER BY wickets DESC
  }
  end
end
