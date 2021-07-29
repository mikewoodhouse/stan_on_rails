def write_table_to_json(t)
  col_names = t.columns.map(&:name).reject! { |n| %w{created_at updated_at}.include?(n) }
  qry = "SELECT #{col_names.join(",")} FROM #{t.table_name}"
  rows = t.find_by_sql(qry)
  File.open("app/javascript/#{t.table_name}.json", "w") do |f|
    f.write rows.to_json
  end
end

namespace :export do
  desc "export all tables to JSON"
  task all: :environment do
    Zeitwerk::Loader.eager_load_all
    ApplicationRecord.descendants.each do |t|
      write_table_to_json(t)
    end
  end
end
