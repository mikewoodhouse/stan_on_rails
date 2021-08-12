# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :reports_menu

  def reports_menu
    Hash.new { |h, k| h[k] = [] }.tap do |h|
      report_specs.each do |spec|
        h[spec.menu] << spec.menu_entry if spec.menu
      end
    end
  end

  def report_specs
    Rails.configuration.reports.map do |report_def|
      Report::Spec.from_h(report_def)
    end
  end
end
