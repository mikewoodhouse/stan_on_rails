class Report::CareerBatting < Report
  def initialize(params)
    super
    @title = "Career Batting Averages"
    @subtitle = "Minimum innings: #{min_innings}"
    @columns = [
      Field.new("name", "Name", "name"),
      Field.new("matches", "Matches", "number"),
      Field.new("innings", "Innings", "number"),
      Field.new("notout", "Not Out", "number"),
      Field.new("high_score", "Highest", "number"),
      Field.new("runsscored", "Runs", "number"),
      Field.new("batave", "Average", "number", "2dp"),
      Field.new("fours", "Fours", "number"),
      Field.new("sixes", "Sixes", "number"),
      Field.new("fifties", "Fifties", "number"),
      Field.new("hundreds", "Hundreds", "number"),
    ]
  end

  def execute()
    super [min_innings]
  end

  def min_innings
    @params[:min_innings] || 50
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
      p.id
    , lkup.name
    , Sum(b.matches) matches
    , Sum(b.innings) innings
    , Sum(b.notout) notout
    , (SELECT Max(pf.highest) FROM performances pf WHERE pf.player_id = p.id) ||
      CASE (
          SELECT Max(f.highestnotout)
          FROM performances f
          WHERE f.player_id = p.id
          AND f.highest = (
              SELECT Max(ff.highest)
              FROM performances ff
              WHERE ff.player_id = p.id)
      ) WHEN 1 THEN '*' ELSE '' END high_score
    , Sum(b.runsscored) runsscored
    , CASE Sum(b.innings)
        WHEN Sum(b.notout) THEN 0.0
        ELSE Sum(Cast(b.runsscored AS REAL)) / (Sum(b.innings) - Sum(b.notout))
      END batave
    , Sum(b.fours) fours
    , Sum(b.sixes) sixes
    , Sum(b.fifties) fifties
    , Sum(b.hundreds) hundreds
    FROM
      players p
        INNER JOIN
          performances b ON b.player_id = p.id
        INNER JOIN
            player_lookup lkup ON lkup.id = p.id
    GROUP BY
      p.id
    , lkup.name
    HAVING
      Sum(b.innings) - Sum(b.notout) >= $1
    ORDER BY batave DESC
    }
  end
end
