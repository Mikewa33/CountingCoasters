# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180918062903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coaster_companies", force: :cascade do |t|
    t.bigint "coaster_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coaster_id"], name: "index_coaster_companies_on_coaster_id"
    t.index ["company_id"], name: "index_coaster_companies_on_company_id"
  end

  create_table "coaster_model_types", force: :cascade do |t|
    t.bigint "coaster_id"
    t.bigint "coaster_model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coaster_id"], name: "index_coaster_model_types_on_coaster_id"
    t.index ["coaster_model_id"], name: "index_coaster_model_types_on_coaster_model_id"
  end

  create_table "coaster_models", force: :cascade do |t|
    t.integer "api_id"
    t.string "status"
    t.string "name"
    t.bigint "company_id"
    t.bigint "model_line_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_coaster_models_on_company_id"
    t.index ["model_line_id"], name: "index_coaster_models_on_model_line_id"
  end

  create_table "coasters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "park_id"
    t.string "name"
    t.string "status"
    t.string "coaster_type"
    t.string "coaster_design"
    t.string "opened"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "long", precision: 10, scale: 6
    t.integer "api_id"
    t.string "park_name"
    t.string "coaster_length"
    t.string "coaster_height"
    t.string "coaster_drop"
    t.string "coaster_speed"
    t.string "coaster_inversions"
    t.string "coaster_duration"
    t.index ["park_id"], name: "index_coasters_on_park_id"
  end

  create_table "companies", force: :cascade do |t|
    t.integer "api_id"
    t.string "status"
    t.string "location"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "model_lines", force: :cascade do |t|
    t.integer "api_id"
    t.string "status"
    t.string "name"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_model_lines_on_company_id"
  end

  create_table "parks", force: :cascade do |t|
    t.integer "api_id"
    t.string "status"
    t.string "location"
    t.string "name"
    t.string "open_date"
    t.string "website_url"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "long", precision: 10, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country"
    t.string "state"
    t.string "county"
    t.string "district"
    t.string "city"
  end

  create_table "user_coasters", force: :cascade do |t|
    t.uuid "user_id"
    t.bigint "coaster_id"
    t.boolean "has_rode"
    t.integer "ride_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coaster_id"], name: "index_user_coasters_on_coaster_id"
  end

  create_table "user_parks", force: :cascade do |t|
    t.uuid "user_id"
    t.bigint "park_id"
    t.boolean "has_visited"
    t.integer "visit_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_user_parks_on_park_id"
  end

end
