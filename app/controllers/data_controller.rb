REPORT_MAP = {
  "players" => PlayersReport,
}

class DataController < ApplicationController
  def get
    report = REPORT_MAP[params[:dataset]].new
    report.execute
    puts report.to_h
    respond_to do |format|
      format.json {
        render json: report.to_h
      }
    end
  end

  def records
    @page_title = "Statistical Loveliness"
  end
end
