require "csv"

def cleanup_imported_types(h, string_cols, boolean_cols)
  h.each do |k, v|
    if string_cols.include?(k)
      next
    elsif boolean_cols.include?(k)
      h[k] = (v == 1)
    else
      h[k] = v.to_i
    end
  end
end

namespace :import do
  CSV_PATH = "#{Rails.public_path}/csvdata"

  desc "import all the data"
  task everything: :performances do
    puts "#{Player.count} players"
    puts "#{Performance.count} performances"
  end

  desc "import player csv data"
  task players: :environment do
    csv_file = File.join(CSV_PATH, "Player.txt")
    Player.destroy_all
    File.open(csv_file, "r") do |fin|
      hdr_line = fin.readline
      hdrs = CSV.parse(hdr_line).flatten
      hdrs = hdrs.map { |h| h.downcase }
      until fin.eof
        line = fin.readline
        vals = CSV.parse(line).flatten
        player = Player.create(Hash[hdrs.zip(vals)])
      end
    end
  end

  desc "import player performance csv data"
  task performances: :players do
    csv_file = File.join(CSV_PATH, "Performance.txt")
    Performance.destroy_all
    player_id_lookup = Hash[Player.all.map { |p| [p.code, p.id] }]
    File.open(csv_file, "r") do |fin|
      hdr_line = fin.readline
      hdrs = CSV.parse(hdr_line).flatten.map { |h| h.downcase }
      until fin.eof
        vals = CSV.parse(fin.readline).flatten
        perf_hash = cleanup_imported_types(Hash[hdrs.zip(vals)], %w{code}, %w{highestnotout})
        perf = Performance.new(perf_hash)
        perf.player_id = player_id_lookup[perf_hash["code"]]
        perf.save!
      end
    end
  end
end
