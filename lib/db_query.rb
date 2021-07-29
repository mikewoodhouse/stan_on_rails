class DbQuery
  def players
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
end
