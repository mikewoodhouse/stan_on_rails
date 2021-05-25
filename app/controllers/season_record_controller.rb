class SeasonRecordController < ApplicationController
  def index
    @page_title = "Season Records: Trinity & Opponents"
    @season_records = Hash.new { |h, year| h[year] = { 'TCC': nil, 'Opp': nil } }
    SeasonRecord.all.order("year DESC").each do |ssn_rec|
      @season_records[ssn_rec.year][ssn_rec.club] = ssn_rec
    end
  end
end
