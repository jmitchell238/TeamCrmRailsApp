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

ActiveRecord::Schema[7.1].define(version: 2023_11_29_181930) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lap_times", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "leaderboard_id", null: false
    t.decimal "lap_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["leaderboard_id"], name: "index_lap_times_on_leaderboard_id"
    t.index ["user_id"], name: "index_lap_times_on_user_id"
  end

  create_table "leaderboards", force: :cascade do |t|
    t.bigint "track_id", null: false
    t.string "weather_condition"
    t.string "time_of_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "track_condition"
    t.string "track_type"
    t.string "track_name"
    t.index ["track_id"], name: "index_leaderboards_on_track_id"
  end

  create_table "race_participations", force: :cascade do |t|
    t.bigint "user_registration_id", null: false
    t.bigint "race_id", null: false
    t.integer "position"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_id"], name: "index_race_participations_on_race_id"
    t.index ["user_registration_id"], name: "index_race_participations_on_user_registration_id"
  end

  create_table "races", force: :cascade do |t|
    t.bigint "round_id", null: false
    t.string "race_type", null: false
    t.string "main_category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id"], name: "index_races_on_round_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "tournament_id", null: false
    t.bigint "track_id", null: false
    t.string "name"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_rounds_on_tournament_id"
    t.index ["track_id"], name: "index_rounds_on_track_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "start_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.string "track_name"
    t.string "track_type"
    t.string "track_description"
    t.string "track_pack"
    t.string "track_image_uri"
    t.string "track_video_preview_uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "track_map_uri"
    t.string "track_weather_conditions", default: [], array: true
    t.string "track_times_of_day", default: [], array: true
    t.string "track_conditions", default: [], array: true
  end

  create_table "user_registrations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tournament_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_user_registrations_on_tournament_id"
    t.index ["user_id", "tournament_id"], name: "index_user_registrations_on_user_id_and_tournament_id", unique: true
    t.index ["user_id"], name: "index_user_registrations_on_user_id"
  end

  create_table "user_scores", force: :cascade do |t|
    t.bigint "user_registration_id", null: false
    t.bigint "round_id", null: false
    t.integer "points", default: 0
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id"], name: "index_user_scores_on_round_id"
    t.index ["user_registration_id"], name: "index_user_scores_on_user_registration_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "gamer_tag"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "roles", default: [], array: true
  end

  add_foreign_key "lap_times", "leaderboards"
  add_foreign_key "lap_times", "users"
  add_foreign_key "leaderboards", "tracks"
  add_foreign_key "race_participations", "races"
  add_foreign_key "race_participations", "user_registrations"
  add_foreign_key "races", "rounds"
  add_foreign_key "rounds", "tournaments"
  add_foreign_key "rounds", "tracks"
  add_foreign_key "user_registrations", "tournaments"
  add_foreign_key "user_registrations", "users"
  add_foreign_key "user_scores", "rounds"
  add_foreign_key "user_scores", "user_registrations"
end
