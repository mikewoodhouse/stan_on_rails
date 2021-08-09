# frozen_string_literal: true

class ReportController < ApplicationController
  before_action :cleanup_params

  def home
    render 'home'
  end

  def get
    report = REPORT_MAP[params[:dataset]].new(params)
    report.execute
    respond_to do |format|
      format.json do
        render json: report.to_h
      end
    end
  end

  def cleanup_params
    return unless params[:min_innings]

    params[:min_innings] = params[:min_innings].to_i
  end

  def fetch
    key = params[:key]
    report_def = report_defs.find { |s| s[:key] == key }
    spec = Report::Spec.from_h(report_def)
    report = Report::Base.from_spec(spec, params)
    report.execute([100, 2000])
    respond_to do |format|
      format.json do
        render json: report.to_h
      end
    end
  end
end
