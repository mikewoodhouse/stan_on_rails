class SeasonRecordController < ApplicationController
  def index
    @season_records = SeasonRecord.all
  end
end
