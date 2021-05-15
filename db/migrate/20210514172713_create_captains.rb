class CreateCaptains < ActiveRecord::Migration[6.1]
  def change
    create_table :captains do |t|
      t.string :code
      t.integer :year
      t.integer :matches
      t.integer :won
      t.integer :lost
      t.integer :drawn
      t.integer :nodecision
      t.integer :tied

      t.timestamps
    end
  end
end
