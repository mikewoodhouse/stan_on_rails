REPORT_MAP = {
  "players" => PlayersReport,
  "best_bowling" => BestBowlingReport,
  "captains" => CaptainsReport,
}

class ReportController < ApplicationController
  def home
    render "home"
  end

  def get
    report = REPORT_MAP[params[:dataset]].new
    report.execute
    respond_to do |format|
      format.json {
        render json: report.to_h
      }
    end
  end
end
