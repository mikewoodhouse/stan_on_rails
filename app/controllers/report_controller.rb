REPORT_MAP = {
  "players" => Report::Players,
  "best_bowling" => Report::BestBowling,
  "captains" => Report::Captains,
  "results" => Report::SeasonResults,
  "perf" => Report::Performance,
  "wickets" => Report::Wickets,
}

class ReportController < ApplicationController
  def home
    render "home"
  end

  def get
    report = REPORT_MAP[params[:dataset]].new(params)
    report.execute
    respond_to do |format|
      format.json {
        render json: report.to_h
      }
    end
  end
end
