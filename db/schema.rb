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

ActiveRecord::Schema.define(version: 1) do

  create_table "usuaries", force: :cascade do |t|
    t.string "telegram_id"
    t.string "telegram_username"
    t.json "telegram_data"
    t.string "pronombres"
    t.string "privados"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["telegram_id"], name: "index_usuaries_on_telegram_id", unique: true
    t.index ["telegram_username"], name: "index_usuaries_on_telegram_username"
  end

end
