# frozen_string_literal: true

module Report
  class SeasonResults < Report::Base
    def initialize(_params)
      @title = 'Result Summary - Season by Season'
      @columns = [
        Field.new('year', 'Year', 'year'),
        Field.new('played', 'Played', 'number'),
        Field.new('won', 'Won', 'number'),
        Field.new('lost', 'Lost', 'number'),
        Field.new('drawn', 'Drew', 'number'),
        Field.new('tied', 'Tied', 'number'),
        Field.new('noresult', 'N/D', 'number')
      ]
    end

    def sql
      %{
      SELECT
        year
      , played
      , won
      , lost
      , drawn
      , tied
      , noresult
      , 0 is_totals
      FROM seasons
      UNION
      SELECT
        'Total' year
      , Sum(played) played
      , Sum(won) won
      , Sum(lost) lost
      , Sum(drawn) drawn
      , Sum(tied) tied
      , Sum(noresult) noresult
      , 1 is_totals
      FROM seasons
      ORDER BY is_totals DESC, year DESC
    }
    end
  end
end
