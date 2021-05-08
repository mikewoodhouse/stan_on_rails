class CreatePerformances < ActiveRecord::Migration[6.1]
  def change
    create_table :performances do |t|
      t.belongs_to :player, index: true, foreign_key: true

      t.string :code
      t.integer :year
      t.integer :matches
      t.integer :innings
      t.integer :notout
      t.integer :highest
      t.boolean :highestnotout
      t.integer :runsscored
      t.integer :fours
      t.integer :sixes
      t.integer :overs
      t.integer :balls
      t.integer :maidens
      t.integer :wides
      t.integer :noballs
      t.integer :runs
      t.integer :wickets
      t.integer :fivewktinn
      t.integer :caught
      t.integer :stumped
      t.integer :fifties
      t.integer :hundreds
      t.integer :fives
      t.integer :caughtwkt
      t.integer :captain
      t.integer :keptwicket

      t.timestamps
    end
  end
end
