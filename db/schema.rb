# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_07_152729) do

  create_table "performances", force: :cascade do |t|
    t.string "code"
    t.integer "year"
    t.integer "matches"
    t.integer "innings"
    t.integer "notout"
    t.integer "highest"
    t.boolean "highestnotout"
    t.integer "runsscored"
    t.integer "fours"
    t.integer "sixes"
    t.integer "overs"
    t.integer "balls"
    t.integer "maidens"
    t.integer "wides"
    t.integer "noballs"
    t.integer "runs"
    t.integer "wickets"
    t.integer "fivewktinn"
    t.integer "caught"
    t.integer "stumped"
    t.integer "fifties"
    t.integer "hundreds"
    t.integer "fives"
    t.integer "caughtwkt"
    t.integer "captain"
    t.integer "keptwicket"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "code"
    t.string "surname"
    t.string "initial"
    t.string "firstname"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
