class Report::Performance < Report
  def initialize(params)
    super
    player_name = Player.find(params[:id].to_i).surname
    @title = "Player Performance History: #{player_name}"
    @subtitle = "Season by season"
    @columns = [
      Field.new("year", "Year", "year"),
      Field.new("matches", "Matches", "number"),
      Field.new("innings", "Innings", "number"),
      Field.new("notout", "Not Out", "number"),
      Field.new("high_score", "Highest", "number"),
      Field.new("runsscored", "Runs", "number"),
      Field.new("fours", "Fours", "number"),
      Field.new("sixes", "Sixes", "number"),
      Field.new("overs", "Overs", "number"),
      Field.new("balls", "Balls", "number"),
      Field.new("maidens", "Maidens", "number"),
      Field.new("runs", "Runs", "number"),
      Field.new("wickets", "Wickets", "number"),
      Field.new("fivewktinn", "Five+", "number"),
      Field.new("caught", "Caught", "number"),
      Field.new("stumped", "Stumped", "number"),
      Field.new("fifties", "Fifties", "number"),
      Field.new("hundreds", "Hundreds", "number"),
      Field.new("caughtwkt", "Ct Wkt", "number"),
      Field.new("captain", "Captain", "number"),
      Field.new("keptwicket", "Kept Wkt", "number"),
    ]
  end

  def execute
    puts "#execute"
    puts @params
    super [@params["id"].to_i]
  end

  def sql
    %{
      SELECT
        year
      , matches
      , innings
      , notout
      , highest || CASE WHEN highestnotout = 1 THEN '*' ELSE '' END high_score
      , runsscored
      , fours
      , sixes
      , overs
      , balls
      , maidens
      , wides
      , noballs
      , runs
      , wickets
      , fivewktinn
      , caught
      , stumped
      , fifties
      , hundreds
      , fives
      , caughtwkt
      , captain
      , keptwicket
      FROM performances
      WHERE player_id = $1
      UNION
      SELECT
        'TOTAL'
      , Sum(matches)
      , Sum(innings)
      , Sum(notout)
      , (SELECT MAX(highest) FROM performances WHERE player_id = $1) ||
        CASE (
            SELECT Max(highestnotout)
            FROM performances
            WHERE player_id = $1
            AND highest = (
                SELECT Max(highest)
                FROM performances
                WHERE player_id = $1)
        ) WHEN 1 THEN '*' ELSE '' END high_score
      , Sum(runsscored)
      , Sum(fours)
      , Sum(sixes)
      , Sum(overs)
      , Sum(balls)
      , Sum(maidens)
      , Sum(wides)
      , Sum(noballs)
      , Sum(runs)
      , Sum(wickets)
      , Sum(fivewktinn)
      , Sum(caught)
      , Sum(stumped)
      , Sum(fifties)
      , Sum(hundreds)
      , Sum(fives)
      , Sum(caughtwkt)
      , Sum(captain)
      , Sum(keptwicket)
      FROM performances
      WHERE player_id = $1
    }
  end
end
