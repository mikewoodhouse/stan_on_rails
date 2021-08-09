# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :reports_menu

  def reports_menu
    Hash.new { |h, k| h[k] = [] }.tap do |h|
      report_defs.each do |item|
        if item[:menu]
          h[item[:menu]] << [item[:key], item[:title]]
        end
      end
    end
  end

  def report_defs
    @defs = Rails.configuration.reports[:report_defs]
  end
end
