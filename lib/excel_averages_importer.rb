require 'rubyXL'
require 'rubyXL/convenience_methods'

class ExcelAveragesImporter
  def initialize(path)
    @path = path
  end
  def import
    wkbk = RubyXL::Parser.parse(@path)
    matches = wkbk["Matches"]
    MatchImporter.new(year_from(@path)).import(matches.sheet_data)
  end
  def year_from(p)
    /\d+/.match(p)[0]
  end
end

class MatchImporter
  def initialize(year)
    @year = year.to_i
  end
  def import(sheet_data)
    # sheet_data.rows.each do |row|
    #   date = row[1].value
    #   result = row[4].value
    #   next if date.nil? or result.nil?
    #   match = Match.new(row)
    # end
    matches = sheet_data.rows.select{|row| match_row?(row)}.map{|row| Match.new(row)}
    puts matches[0].to_s
  end
  def match_row?(row)
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
  14=> :tocc_w,
  15 => :tocc_nb,
  16 => :tocc_b,
  17 => :tocc_lb,
  18 => :opp_w,
  19 => :opp_nb,
  20 => :opp_b,
  21 => :opp_lb,
}

class Match
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