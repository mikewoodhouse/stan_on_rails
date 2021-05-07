class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :code
      t.string :surname
      t.string :initial
      t.string :firstname
      t.bool :active

      t.timestamps
    end
  end
end
