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

ActiveRecord::Schema.define(version: 2021_04_02_051641) do

  create_table "months", charset: "utf8", force: :cascade do |t|
    t.integer "month"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "year"
    t.index ["year", "month"], name: "index_months_on_year_and_month", unique: true
  end

  create_table "target_lists", charset: "utf8", force: :cascade do |t|
    t.string "target_text"
    t.integer "target_num"
    t.bigint "month_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["month_id"], name: "index_target_lists_on_month_id"
  end

  create_table "week_done_lists", charset: "utf8", force: :cascade do |t|
    t.bigint "week_id"
    t.bigint "target_list_id"
    t.integer "done_num"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["target_list_id"], name: "index_week_done_lists_on_target_list_id"
    t.index ["week_id", "target_list_id"], name: "index_week_done_lists_on_week_id_and_target_list_id", unique: true
    t.index ["week_id"], name: "index_week_done_lists_on_week_id"
  end

  create_table "weeks", charset: "utf8", force: :cascade do |t|
    t.integer "week"
    t.bigint "month_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["month_id"], name: "index_weeks_on_month_id"
  end

  add_foreign_key "target_lists", "months"
  add_foreign_key "week_done_lists", "target_lists"
  add_foreign_key "week_done_lists", "weeks"
  add_foreign_key "weeks", "months"
end
