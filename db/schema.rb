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

ActiveRecord::Schema.define(version: 20180409123002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.integer "category"
    t.boolean "mayoral"
    t.boolean "citynet"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agency_services", force: :cascade do |t|
    t.bigint "agency_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_agency_services_on_agency_id"
    t.index ["service_id"], name: "index_agency_services_on_service_id"
  end

  create_table "arm_agencies", force: :cascade do |t|
    t.integer "arm_id"
    t.bigint "agency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_arm_agencies_on_agency_id"
  end

  create_table "cio_agencies", force: :cascade do |t|
    t.integer "cio_id"
    t.bigint "agency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_cio_agencies_on_agency_id"
  end

  create_table "commissioner_agencies", force: :cascade do |t|
    t.integer "commissioner_id"
    t.bigint "agency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_commissioner_agencies_on_agency_id"
  end

  create_table "connection_engagements", force: :cascade do |t|
    t.bigint "connection_id"
    t.bigint "engagement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["connection_id"], name: "index_connection_engagements_on_connection_id"
    t.index ["engagement_id"], name: "index_connection_engagements_on_engagement_id"
  end

  create_table "connection_types", force: :cascade do |t|
    t.string "via"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "connections", force: :cascade do |t|
    t.datetime "date"
    t.string "report"
    t.text "notes"
    t.integer "arm_id"
    t.bigint "agency_id"
    t.bigint "connection_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_connections_on_agency_id"
    t.index ["connection_type_id"], name: "index_connections_on_connection_type_id"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name"
    t.integer "deputy_commissioner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "engagement_types", force: :cascade do |t|
    t.string "via"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "engagements", force: :cascade do |t|
    t.text "report"
    t.text "notes"
    t.string "ksr"
    t.string "inc"
    t.string "prj"
    t.integer "priority"
    t.bigint "service_id"
    t.bigint "engagement_type_id"
    t.integer "created_by_id"
    t.datetime "start_time"
    t.datetime "last_modified_on"
    t.integer "last_modified_by_id"
    t.datetime "resolved_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["engagement_type_id"], name: "index_engagements_on_engagement_type_id"
    t.index ["service_id"], name: "index_engagements_on_service_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "location"
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "executive_communications", force: :cascade do |t|
    t.string "subject"
    t.text "content"
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "sla"
    t.integer "sdl_id"
    t.integer "service_owner_id"
    t.boolean "core"
    t.bigint "division_id"
    t.bigint "service_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["division_id"], name: "index_services_on_division_id"
    t.index ["service_category_id"], name: "index_services_on_service_category_id"
  end

  create_table "staff_connections", force: :cascade do |t|
    t.bigint "staff_id"
    t.bigint "connection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["connection_id"], name: "index_staff_connections_on_connection_id"
    t.index ["staff_id"], name: "index_staff_connections_on_staff_id"
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
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "cell_phone"
    t.string "office_phone"
    t.bigint "role_id"
    t.bigint "agency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_staffs_on_agency_id"
    t.index ["role_id"], name: "index_staffs_on_role_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "engagements", "engagement_types"
  add_foreign_key "staff_connections", "connections"
  add_foreign_key "staff_connections", "staffs"
  add_foreign_key "staff_engagements", "engagements"
  add_foreign_key "staff_engagements", "staffs"
end
