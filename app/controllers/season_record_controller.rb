class SeasonRecordController < ApplicationController
  def index
    @season_records = Hash.new { |h, year| h[year] = { 'TCC': nil, 'Opp': nil } }
    puts @season_records
    SeasonRecord.all.each do |ssn_rec|
      @season_records[ssn_rec.year][ssn_rec.club] = ssn_rec
    end
  end
end
