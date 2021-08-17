# frozen_string_literal: true

require 'importer'

namespace :import do
  desc 'import all the data'
  task all: :environment do
    {
      Player => { bool_cols: %w[active], string_cols: %w[code surname initial firstname] },
      Performance => { string_cols: %w[code], bool_cols: %w[highestnotout], col_map: { 'code': 'player_id' } },
      Season => {},
      SeasonRecord => { string_cols: %w[club highestopps lowestopps], date_cols: %w[highestdate lowestdate] },
      HundredPlus => { string_cols: %w[code opponents], date_cols: %w[date], bool_cols: %w[notout],
                       col_map: { 'code': 'player_id' } },
      BestBowling => { string_cols: %w[code opp], date_cols: %w[date], col_map: { 'code': 'player_id' } },
      Captain => { string_cols: %w[code], input_filename: 'Captains', col_map: { 'code': 'player_id' } },
      Partnership => { string_cols: %w[bat1 bat2 opp], date_cols: %w[date],
                       bool_cols: %w[bat1notout bat2notout undefeated], col_map: { 'bat1': 'bat1_id', 'bat2': 'bat2_id' } }
    }.each do |klass, opts|
      Importer.new(klass, opts).import
    end
  end
end
