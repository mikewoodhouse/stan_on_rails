class BestBowlingReport < Report
  def execute
    @rows = ActiveRecord::Base.connection.exec_query(sql, "BestBowling")
  end

  def columns
    [
      Field.new("name", "Name"),
      Field.new("wkts", "Wickets", "number"),
      Field.new("runs", "Runs", "number"),
      Field.new("opp", "Opposition"),
      Field.new("date", "Date", "date"),
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
      , bb.date
      , bb.wkts
      , bb.runs
      , bb.opp
      FROM
        player_lookup p
          INNER JOIN
            best_bowlings bb ON bb.player_id = p.id
      ORDER BY
        bb.wkts DESC
      , bb.runs ASC
      , bb.date
    }
  end

  def to_h
    {
      "title" => "Best Bowling",
      "columns" => columns,
      "data" => @rows.to_a,
    }
  end
end
