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

ActiveRecord::Schema.define(version: 2021_11_22_234728) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.bigint "station_id", null: false
    t.string "title"
    t.integer "muscle_group"
    t.string "good_for"
    t.string "bad_for"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["station_id"], name: "index_exercises_on_station_id"
  end

  create_table "stations", force: :cascade do |t|
    t.float "base_incremental_weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "age"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workout_sets", force: :cascade do |t|
    t.bigint "exercise_id", null: false
    t.bigint "workout_id", null: false
    t.integer "nb_of_reps"
    t.integer "order_index"
    t.float "weight"
    t.integer "difficulty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "time"
    t.index ["exercise_id"], name: "index_workout_sets_on_exercise_id"
    t.index ["workout_id"], name: "index_workout_sets_on_workout_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "template"
    t.date "day"
    t.text "pro_and_cons"
    t.string "mental_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "exercises", "stations"
  add_foreign_key "workout_sets", "exercises"
  add_foreign_key "workout_sets", "workouts"
  add_foreign_key "workouts", "users"
end
