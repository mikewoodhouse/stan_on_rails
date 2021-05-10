require "csv"

def cleanup_imported_types(h, string_cols, boolean_cols)
  h.each do |k, v|
    if string_cols.include?(k)
      h[k] = v
    elsif boolean_cols.include?(k)
      h[k] = (v.to_i == 1)
    else
      h[k] = v.to_i
    end
  end
end

def import_model_data(spec)
  klass = spec[:klass]
  file_base_name = spec[:txt_file_name] || klass.to_s
  file_name = file_base_name + ".txt"
  csv_file = File.join(CSV_PATH, file_name)
  klass.destroy_all
  player_id_lookup = Hash[Player.all.map { |p| [p.code, p.id] }]
  string_cols = spec[:string_cols] || []
  bool_cols = spec[:bool_cols] || []
  player_id_col_map = spec[:col_map] || {}
  File.open(csv_file, "r") do |fin|
    hdr_line = fin.readline
    hdrs = CSV.parse(hdr_line).flatten
    hdrs = hdrs.map { |h| h.downcase }
    until fin.eof
      line = fin.readline
      vals = CSV.parse(line).flatten
      value_hash = cleanup_imported_types(Hash[hdrs.zip(vals)], string_cols, bool_cols)
      klass.new(value_hash) do |obj|
        player_id_col_map.each do |in_col, out_col|
          puts "#{obj["code"]} => #{player_id_lookup[value_hash["code"]]}"
          puts "obj[#{out_col}] = player_id_lookup[obj[#{in_col}]] = player_id_lookup[#{obj[in_col]}] = #{player_id_lookup[obj[in_col]]}"
          obj[out_col] = player_id_lookup[obj[in_col]]
        end
        obj.save!
      end
    end
  end
  puts "#{klass.count} records loaded for #{klass}"
end

namespace :import do
  CSV_PATH = "#{Rails.public_path}/csvdata"

  desc "import all the data"
  task everything: [:players, :performances] do
  end

  desc "import player csv data"
  task players: :environment do
    import_model_data(klass: Player, bool_cols: %w{active}, string_cols: %w{code surname initial firstname})
  end

  desc "import player performance csv data"
  task performances: :environment do
    import_model_data(klass: Performance, string_cols: %w{code}, bool_cols: %w{highestnotout},
                      col_map: { 'code': "player_id" })
  end
end
