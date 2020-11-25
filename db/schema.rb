# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_25_100031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "strava_athletes", force: :cascade do |t|
    t.integer "strava_id"
    t.string "username"
    t.integer "resource_state"
    t.string "firstname"
    t.string "lastname"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "sex"
    t.boolean "premium"
    t.boolean "summit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "badge_type_id"
    t.string "profile_medium"
    t.string "profile"
    t.string "friend"
    t.string "follower"
    t.index ["strava_id"], name: "index_strava_athletes_on_strava_id", unique: true
  end

  create_table "stravas", force: :cascade do |t|
    t.string "code"
    t.string "scope"
    t.string "state"
    t.integer "expires_at"
    t.integer "expires_in"
    t.string "refresh_token"
    t.string "access_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "strava_athlete_id"
  end

end
