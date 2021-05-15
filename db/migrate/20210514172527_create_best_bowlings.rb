class CreateBestBowlings < ActiveRecord::Migration[6.1]
  def change
    create_table :best_bowlings do |t|
      t.integer :year
      t.string :code
      t.date :date
      t.integer :inns
      t.integer :wkts
      t.integer :runs
      t.string :opp

      t.timestamps
    end
  end
end
