class PlayersReport < Report
  def execute
    @rows = ActiveRecord::Base.connection.exec_query(sql, "Players", [100, 2010])
  end

  def columns
    [
      Field.new("name", "Name", ""),
      Field.new("from_yr", "From", "year"),
      Field.new("to_yr", "To", "year"),
      Field.new("appearances", "Appearances", "number"),
    ].map(&:to_h)
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
        , min(f.year) from_yr
        , max(f.year) to_yr
        , Sum(f.matches) appearances
        FROM players p
            INNER JOIN performances f
            ON f.player_id = p.id
            INNER JOIN player_lookup lkup
            ON lkup.id = p.id
        GROUP BY
            p.id
        HAVING
            Sum(f.matches) >= $1
        AND Max(f.year) >= $2
        ORDER BY lkup.name
        }
  end

  def to_h
    {
      "title" => "Players",
      "columns" => columns,
      "data" => @rows.to_a,
    }
  end
end
