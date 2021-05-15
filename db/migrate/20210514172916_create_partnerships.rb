class CreatePartnerships < ActiveRecord::Migration[6.1]
  def change
    create_table :partnerships do |t|
      t.integer :year
      t.integer :wicket
      t.date :date
      t.integer :total
      t.boolean :undefeated
      t.string :bat1
      t.integer :bat1score
      t.boolean :bat1notout
      t.string :bat2
      t.integer :bat2score
      t.boolean :bat2notout
      t.string :opp

      t.timestamps
    end
  end
end
