require 'csv'

namespace :import do
  CSV_PATH = "#{Rails.public_path}/csvdata"
  desc "import player csv data"
  task players: :environment do
    print Rails.public_path
    csv_file = File.join(CSV_PATH, 'Player.txt')
    Player.destroy_all
    File.open(csv_file, 'r') do |fin|
      hdr_line = fin.readline
      hdrs = CSV.parse(hdr_line).flatten
      hdrs = hdrs.map{|h| h.downcase}
      until fin.eof do
        line = fin.readline
        vals = CSV.parse(line).flatten
        player = Player.create!(Hash[hdrs.zip(vals)])
      end
    end
  end
end