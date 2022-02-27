class CreateMatch < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.date :date
      t.string :oppo
      t.string :venue
      t.string :result
      t.string :bat_first
      t.integer :first_runs
      t.integer :first_wkts
      t.boolean :first_all_out
      t.string :first_notes
      t.integer :second_runs
      t.integer :second_wkts
      t.boolean :second_all_out
      t.string :second_notes
      t.integer :tocc_w
      t.integer :tocc_nb
      t.integer :tocc_b
      t.integer :tocc_lb
      t.integer :opp_w
      t.integer :opp_nb
      t.integer :opp_b
      t.integer :opp_lb

      t.timestamps
    end
  end
end
