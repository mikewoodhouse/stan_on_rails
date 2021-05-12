require "importer"

namespace :import do
  CSV_PATH = "#{Rails.public_path}/csvdata"

  desc "import all the data"
  task everything: :environment do
    importer = Importer.new
    importer.import_model_data klass: Player, bool_cols: %w{active}, string_cols: %w{code surname initial firstname}
    importer.import_model_data klass: Performance, string_cols: %w{code}, bool_cols: %w{highestnotout},
                               col_map: { 'code': "player_id" }
    importer.import_model_data klass: Season
    importer.import_model_data klass: SeasonRecord, string_cols: %w{club highestopps lowestopps}, date_cols: %w{highestdate lowestdate}
    importer.import_model_data klass: HundredPlus, string_cols: %w{code opponents}, date_cols: %w{date}, bool_cols: %w{notout}, col_map: { 'code': "player_id" }
  end
end
