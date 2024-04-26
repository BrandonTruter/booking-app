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

ActiveRecord::Schema[7.1].define(version: 2024_04_26_075138) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.text "reason"
    t.string "type"
    t.string "status"
    t.datetime "end_at"
    t.datetime "start_at"
    t.integer "duration"
    t.integer "debtor_id"
    t.integer "patient_id"
    t.bigint "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_bookings_on_diary_id"
  end

  create_table "debtors", force: :cascade do |t|
    t.integer "uid"
    t.string "name"
    t.integer "entity_uid"
    t.string "patient_uids"
    t.bigint "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_debtors_on_booking_id"
  end

  create_table "diaries", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.integer "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "set_default", default: true
    t.uuid "external_id"
    t.bigint "entities_id", null: false
    t.index ["entities_id"], name: "index_diaries_on_entities_id"
  end

  create_table "entities", force: :cascade do |t|
    t.integer "uid"
    t.string "title"
    t.text "description"
    t.string "username"
    t.string "password"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.integer "uid"
    t.string "name"
    t.integer "entity_uid"
    t.integer "debtor_uid"
    t.bigint "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_patients_on_booking_id"
  end

  add_foreign_key "bookings", "diaries"
  add_foreign_key "debtors", "bookings"
  add_foreign_key "diaries", "entities", column: "entities_id"
  add_foreign_key "patients", "bookings"
end
