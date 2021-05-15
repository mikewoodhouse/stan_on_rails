require "importer"

namespace :import do
  desc "import all the data"
  task all: :environment do
    {
      Player => { bool_cols: %w{active}, string_cols: %w{code surname initial firstname} },
      Performance => { string_cols: %w{code}, bool_cols: %w{highestnotout}, col_map: { 'code': "player_id" } },
      Season => {},
      SeasonRecord => { string_cols: %w{club highestopps lowestopps}, date_cols: %w{highestdate lowestdate} },
      HundredPlus => { string_cols: %w{code opponents}, date_cols: %w{date}, bool_cols: %w{notout}, col_map: { 'code': "player_id" } },
      BestBowling => { string_cols: %w{code opp}, date_cols: %w{date} },
      Captain => { string_cols: %w{code}, input_filename: "Captains" },
      Partnership => { string_cols: %w{bat1 bat2 opp}, date_cols: %w{date}, bool_cols: %w{bat1notout bat2notout undefeated} },
    }.each do |klass, opts|
      Importer.new(klass, opts).import
    end
  end
end
