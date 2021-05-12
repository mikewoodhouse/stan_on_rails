require "csv"

class Importer
  def fixup_types(h, cols, transform)
    return unless cols
    cols.each do |col|
      h[col] = transform.call(h[col])
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
    date_cols = spec[:date_cols] || []
    player_id_col_map = spec[:col_map] || {}
    File.open(csv_file, "r") do |fin|
      hdr_line = fin.readline
      hdrs = CSV.parse(hdr_line).flatten
      hdrs = hdrs.map { |h| h.downcase }
      int_cols = hdrs - string_cols - bool_cols - date_cols
      until fin.eof
        line = fin.readline
        vals = CSV.parse(line).flatten
        value_hash = Hash[hdrs.zip(vals)]
        fixup_types value_hash, string_cols, ->(v) { v }
        fixup_types value_hash, bool_cols, ->(v) { v.to_i == 1 }
        fixup_types value_hash, date_cols, ->(v) { v ? Date.parse(v) : v }
        fixup_types value_hash, int_cols, ->(v) { v.to_i }
        klass.new(value_hash) do |obj|
          player_id_col_map.each do |in_col, out_col|
            obj[out_col] = player_id_lookup[obj[in_col]]
          end
          obj.save!
        end
      end
    end
    puts "#{klass.count} records loaded for #{klass}"
  end
end
