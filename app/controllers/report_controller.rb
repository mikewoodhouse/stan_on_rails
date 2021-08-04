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
end
