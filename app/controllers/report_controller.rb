REPORT_MAP = {
  "players" => PlayersReport,
  "best_bowling" => BestBowlingReport,
}

class ReportController < ApplicationController
  def home
  end

  def get
    if params[:dataset]
      report = REPORT_MAP[params[:dataset]].new
      report.execute
      respond_to do |format|
        format.json {
          render json: report.to_h
        }
      end
    else
      render "home"
    end
  end
end
