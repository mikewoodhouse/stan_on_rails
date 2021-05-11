class CreateHundredPlus < ActiveRecord::Migration[6.1]
  def change
    create_table :hundred_plus do |t|
      t.integer :year
      t.integer :player_id
      t.string :code
      t.date :date
      t.integer :score
      t.boolean :notout
      t.string :opponents
      t.integer :minutes

      t.timestamps
    end
  end
end
