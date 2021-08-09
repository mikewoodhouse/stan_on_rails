# frozen_string_literal: true

class ReportController < ApplicationController
  before_action :cleanup_params

  def home
    render 'home'
  end

  def number?(n)
    n.to_f.to_s == n.to_s || n.to_i.to_s == n.to_s
  end

  def cleanup_params
    params.each_key do |k|
      params[k] = params[k].to_i if number?(params[k])
    end
  end

  def fetch
    key = params[:key]
    report_def = report_defs.find { |s| s[:key] == key }
    spec = Report::Spec.from_h(report_def)
    report = Report::Base.from_spec(spec)
    report.execute(params)
    respond_to do |format|
      format.json do
        render json: report.to_h
      end
    end
  end
end
