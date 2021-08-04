# frozen_string_literal: true

module Report
  class Performance < Report::Base
    def initialize(params)
      super
      @player_id = params[:id].to_i
      player_name = Player.find(@player_id).display_name
      @title = "Player Performance History: #{player_name}"
      @subtitle = 'Season by season'
      @columns = [
        Field.new('year', 'Year', 'year'),
        Field.new('matches', 'Matches', 'number'),
        Field.new('innings', 'Innings', 'number'),
        Field.new('notout', 'Not Out', 'number'),
        Field.new('high_score', 'Highest', 'number'),
        Field.new('runsscored', 'Runs', 'number'),
        Field.new('bat_avg', 'Average', 'number', '2dp'),
        Field.new('fours', 'Fours', 'number'),
        Field.new('sixes', 'Sixes', 'number'),
        Field.new('fifties', 'Fifties', 'number'),
        Field.new('hundreds', 'Hundreds', 'number'),
        Field.new('overs', 'Overs', 'number'),
        Field.new('maidens', 'Maidens', 'number'),
        Field.new('runs', 'Runs', 'number'),
        Field.new('wickets', 'Wickets', 'number'),
        Field.new('bowl_avg', 'Average', 'number', '2dp'),
        Field.new('strike_rate', 'Strike Rate', 'number', '2dp'),
        Field.new('econ', 'Econ', 'number', '2dp'),
        Field.new('fivewktinn', 'Five+', 'number'),
        Field.new('caught', 'Caught', 'number'),
        Field.new('stumped', 'Stumped', 'number'),
        Field.new('caughtwkt', 'Ct Wkt', 'number'),
        Field.new('keptwicket', 'Kept Wkt', 'number'),
        Field.new('captain', 'Captain', 'number')
      ]
    end

    def execute
      super [@player_id]
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
      , case innings
          WHEN notout THEN null
          ELSE CAST(runsscored AS FLOAT) / (innings - notout)
          END bat_avg
      , fours
      , sixes
      , (overs * 6 + balls) / 6 + ((overs * 6 + balls) % 6) / 10.0 overs
      , maidens
      , wides
      , noballs
      , runs
      , wickets
      , CASE wickets
        WHEN 0 THEN NULL
        ELSE CAST(runs AS FLOAT) / wickets
        END bowl_avg
      , CASE wickets
        WHEN 0 THEN NULL
        ELSE CAST(overs * 6 + balls AS FLOAT) / wickets
        END strike_rate
      , runs / CAST(overs * 6 + balls AS FLOAT) * 6 econ
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
      , CASE Sum(innings)
        WHEN Sum(notout) THEN null
        ELSE CAST(Sum(runsscored) AS FLOAT) / (Sum(innings) - Sum(notout))
        END bat_avg
      , Sum(fours)
      , Sum(sixes)
      , Sum(overs * 6 + balls) / 6 + (Sum(overs * 6 + balls) % 6) / 10.0 overs
      , Sum(maidens)
      , Sum(wides)
      , Sum(noballs)
      , Sum(runs)
      , Sum(wickets)
      , CASE Sum(wickets)
        WHEN 0 THEN NULL
        ELSE CAST(Sum(runs) AS FLOAT) / Sum(wickets)
        END bowl_avg
      , CASE Sum(wickets)
        WHEN 0 THEN NULL
        ELSE CAST(Sum(overs * 6 + balls) AS FLOAT) / Sum(wickets)
        END strike_rate
      , 6 * Sum(runs) / CAST(Sum(overs * 6 + balls) AS FLOAT) econ
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
end
