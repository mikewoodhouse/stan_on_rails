class Report::Wickets < Report
  def initialize(params)
    super params
    @title = "Career Wickets"
    @columns = [
      Field.new("name", "Name", "name"),
      Field.new("wickets", "Wickets", "number"),
      Field.new("avg", "Average", "number", "2dp"),
      Field.new("strike_rate", "S/R", "number", "2dp"),
      Field.new("econ", "Econ", "number", "2dp"),
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
    , CAST(Sum(b.runs) AS FLOAT) / Sum(b.wickets) avg
    , CAST(Sum(b.overs * 6 + b.balls) AS FLOAT) / Sum(b.wickets) strike_rate
    , Sum(runs) / CAST(Sum(b.overs * 6 + b.balls) AS FLOAT) * 6 econ
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
