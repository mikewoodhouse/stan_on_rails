class ReportController < ApplicationController
  before_action :cleanup_params

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

  def cleanup_params
    if params[:min_innings]
      params[:min_innings] = params[:min_innings].to_i
    end
  end
end
