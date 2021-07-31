class SeasonResultsReport < Report
  def initialize
    @title = "Season Results"
    @columns = [
      Field.new("year", "Year", "year"),
      Field.new("played", "Played", "number"),
      Field.new("won", "Won", "number"),
      Field.new("lost", "Lost", "number"),
      Field.new("drawn", "Drew", "number"),
      Field.new("tied", "Tied", "number"),
      Field.new("noresult", "N/D", "number"),
    ]
  end

  def sql
    %{
      SELECT *
      FROM seasons
      ORDER BY year
    }
  end
end
