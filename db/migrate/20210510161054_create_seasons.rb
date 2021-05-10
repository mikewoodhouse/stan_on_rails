class CreateSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :seasons do |t|
      t.integer :year
      t.integer :played
      t.integer :won
      t.integer :lost
      t.integer :drawn
      t.integer :tied
      t.integer :noresult
      t.integer :maxpossiblegames

      t.timestamps
    end
  end
end
