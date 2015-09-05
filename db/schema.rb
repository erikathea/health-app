# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150905194119) do

  create_table "contact_details", force: :cascade do |t|
    t.string   "address"
    t.string   "email"
    t.string   "landline"
    t.string   "mobile"
    t.string   "fax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "full_names", force: :cascade do |t|
    t.string   "first_name",  limit: 30, null: false
    t.string   "middle_name", limit: 30, null: false
    t.string   "last_name",   limit: 30, null: false
    t.string   "title",       limit: 10
    t.string   "prefix",      limit: 10
    t.string   "suffix",      limit: 10
    t.string   "nickname",    limit: 10
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "health_facilities", force: :cascade do |t|
    t.string   "name",              null: false
    t.integer  "contact_detail_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "health_facilities", ["contact_detail_id"], name: "index_health_facilities_on_contact_detail_id"

  create_table "lab_details", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "value",         null: false
    t.string   "unit"
    t.string   "normal_range"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "lab_record_id"
  end

  create_table "lab_records", force: :cascade do |t|
    t.integer  "patient_id",         null: false
    t.integer  "physician_id",       null: false
    t.integer  "health_facility_id", null: false
    t.string   "name",               null: false
    t.datetime "date_conducted",     null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "lab_records", ["health_facility_id"], name: "index_lab_records_on_health_facility_id"
  add_index "lab_records", ["patient_id"], name: "index_lab_records_on_patient_id"
  add_index "lab_records", ["physician_id"], name: "index_lab_records_on_physician_id"

  create_table "patients", force: :cascade do |t|
    t.integer  "full_name_id",                null: false
    t.integer  "contact_detail_id"
    t.string   "ssn",               limit: 9, null: false
    t.date     "registration_date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "gender"
    t.date     "birth_date"
  end

  add_index "patients", ["contact_detail_id"], name: "index_patients_on_contact_detail_id"
  add_index "patients", ["full_name_id"], name: "index_patients_on_full_name_id"

  create_table "physicians", force: :cascade do |t|
    t.integer  "full_name_id",      null: false
    t.integer  "contact_detail_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "physicians", ["contact_detail_id"], name: "index_physicians_on_contact_detail_id"
  add_index "physicians", ["full_name_id"], name: "index_physicians_on_full_name_id"

end
