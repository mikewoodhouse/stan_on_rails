require 'rubyXL'
require 'rubyXL/convenience_methods'

class ExcelAveragesImporter
  def initialize(path)
    @path = path
  end

  def import
    setup_table
    wkbk = RubyXL::Parser.parse(@path)
    matches = wkbk['Matches']
    MatchImporter.new(year_from(@path)).import(matches.sheet_data)
  end

  def year_from(p)
    /\d+/.match(p)[0]
  end

  def setup_table
    date_cols = %w[date].map(&:to_sym)
    int_cols = %w[first_runs first_wkts second_runs second_wkts tocc_w tocc_nb tocc_b tocc_lb opp_w opp_nb opp_b opp_lb].map(&:to_sym)
    bool_cols = %w[first_all_out second_all_out].map(&:to_sym)
    str_cols = MATCH_COL_MAP.values - (date_cols + int_cols + bool_cols)
  end
end

class MatchImporter
  def initialize(year)
    @year = year.to_i
  end

  def import(sheet_data)
    match_lines = sheet_data.rows.select{ row| match_line?(row)}.map{|row| MatchLine.new(row) }
  end

  def match_line?(row)
    row[1].value.is_a? DateTime and row[4].value
  end
end

MATCH_COL_MAP = {
  1 => :date,
  2 => :oppo,
  3 => :venue,
  4 => :result,
  5 => :bat_first,
  6 => :first_runs,
  7 => :first_wkts,
  8 => :first_all_out,
  9 => :first_notes,
  10 => :second_runs,
  11 => :second_wkts,
  12 => :second_all_out,
  13 => :second_notes,
  14 => :tocc_w,
  15 => :tocc_nb,
  16 => :tocc_b,
  17 => :tocc_lb,
  18 => :opp_w,
  19 => :opp_nb,
  20 => :opp_b,
  21 => :opp_lb
}

class MatchLine
  def initialize(row)
    @fields = Hash.new.tap do |h|
      MATCH_COL_MAP.each do |col, fld|
        h[fld] = row[col].value
      end
    end
  end

  def to_s
    @fields
  end
end
