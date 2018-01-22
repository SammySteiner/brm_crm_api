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

ActiveRecord::Schema.define(version: 20180122183242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.integer "category"
    t.boolean "mayoral"
    t.boolean "citynet"
    t.integer "commissioner_id"
    t.integer "cio_id"
    t.integer "arm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "engagement_types", force: :cascade do |t|
    t.string "medium"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "engagements", force: :cascade do |t|
    t.boolean "cio"
    t.datetime "date"
    t.text "notes"
    t.bigint "engagement_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["engagement_type_id"], name: "index_engagements_on_engagement_type_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "sla"
    t.integer "sdl_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "staff_agencies", force: :cascade do |t|
    t.bigint "staff_id"
    t.bigint "agency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_staff_agencies_on_agency_id"
    t.index ["staff_id"], name: "index_staff_agencies_on_staff_id"
  end

  create_table "staff_engagements", force: :cascade do |t|
    t.bigint "staff_id"
    t.bigint "engagement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["engagement_id"], name: "index_staff_engagements_on_engagement_id"
    t.index ["staff_id"], name: "index_staff_engagements_on_staff_id"
  end

  create_table "staffs", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_staffs_on_role_id"
  end

  add_foreign_key "engagements", "engagement_types"
  add_foreign_key "staff_agencies", "agencies"
  add_foreign_key "staff_agencies", "staffs"
  add_foreign_key "staff_engagements", "engagements"
  add_foreign_key "staff_engagements", "staffs"
  add_foreign_key "staffs", "roles"
end
