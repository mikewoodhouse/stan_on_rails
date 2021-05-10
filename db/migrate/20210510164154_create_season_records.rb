class CreateSeasonRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :season_records do |t|
      t.integer :year
      t.string :club
      t.integer :runsscored
      t.integer :wicketslost
      t.integer :highest
      t.integer :highestwkts
      t.date :highestdate
      t.string :highestopps
      t.integer :lowest
      t.integer :lowestwkts
      t.date :lowestdate
      t.string :lowestopps
      t.integer :byes
      t.integer :legbyes
      t.integer :wides
      t.integer :noballs
      t.integer :ballsbowled
      t.integer :ballsreceived

      t.timestamps
    end
  end
end
