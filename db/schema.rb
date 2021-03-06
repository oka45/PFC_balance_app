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

ActiveRecord::Schema.define(version: 2021_04_01_021324) do

  create_table "foods", charset: "utf8", force: :cascade do |t|
    t.string "food_name"
    t.decimal "protein", precision: 6, scale: 1
    t.decimal "carbohydrate", precision: 6, scale: 1
    t.decimal "fat", precision: 6, scale: 1
    t.decimal "salt_equivalents", precision: 6, scale: 1
    t.decimal "calorie", precision: 6, scale: 1
    t.decimal "quantity", precision: 6, scale: 1
    t.date "date"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "time_zone"
    t.index ["user_id", "created_at"], name: "index_foods_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_foods_on_user_id"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "foods", "users"
end
