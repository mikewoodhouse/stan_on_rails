# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :reports_menu

  def reports_menu
    Hash.new { |h, k| h[k] = [] }.tap do |h|
      report_specs.each_value do |spec|
        h[spec.menu] << spec.menu_entry if spec.menu
      end
    end
  end

  def report_specs
    @report_specs ||= {}.tap do |h|
      Rails.configuration.report_defs.map do |report_def|
        h[report_def.first] = Report::Spec.new(*report_def)
      end
    end
  end
end
