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

ActiveRecord::Schema.define(version: 2021_04_15_081021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "places", force: :cascade do |t|
    t.string "place_name", null: false
    t.string "address", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "lrd"
    t.index ["lrd"], name: "index_places_on_lrd", unique: true
  end

  create_table "results", force: :cascade do |t|
    t.text "place_name"
    t.text "address"
    t.float "star_ave"
    t.integer "count_ave"
    t.integer "text_ave"
    t.float "credible_star_ave"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "place_id"
    t.index ["place_id"], name: "index_results_on_place_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "text", null: false
    t.integer "count", null: false
    t.float "star", null: false
    t.bigint "place_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["place_id"], name: "index_reviews_on_place_id"
  end

  add_foreign_key "results", "places"
  add_foreign_key "reviews", "places"
end
