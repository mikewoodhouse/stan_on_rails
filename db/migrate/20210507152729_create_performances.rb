class CreatePerformances < ActiveRecord::Migration[6.1]
  def change
    create_table :performances do |t|
      t.string :code
      t.int :year
      t.int :matches
      t.int :innings
      t.int :notout
      t.int :highest
      t.boolean :highestnotout
      t.int :runsscored
      t.int :fours
      t.int :sixes
      t.int :overs
      t.int :balls
      t.int :maidens
      t.int :wides
      t.int :noballs
      t.int :runs
      t.int :wickets
      t.int :fivewktinn
      t.int :caught
      t.int :stumped
      t.int :fifties
      t.int :hundreds
      t.int :fives
      t.int :caughtwkt
      t.int :captain
      t.int :keptwicket

      t.timestamps
    end
  end
end
