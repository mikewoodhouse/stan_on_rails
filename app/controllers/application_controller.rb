# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :reports_menu
  REPORTS_MENU = [
    ['Players', nil],
    ['players', 'Appearances', Report::Players],
    ['captains', 'Captains', Report::Captains],
    ['Seasons', nil],
    ['results', 'Results', Report::SeasonResults],
    ['Batting', nil],
    ['career_bat', 'Career Average', Report::CareerBatting],
    ['runs', 'Career Runs', Report::Runs],
    ['Bowling', nil],
    ['best_bowling', 'Five wickets or more', Report::BestBowling],
    ['wickets', 'Career Wickets', Report::Wickets],
    [nil, nil],
    ['perf', Report::Performance]
  ]
  REPORT_MAP = {}.tap do |h|
    REPORTS_MENU.each do |item|
      break unless item.first

      h[item.first] = item.last if item.last
    end
  end

  def reports_menu
    REPORTS_MENU
  end
end
