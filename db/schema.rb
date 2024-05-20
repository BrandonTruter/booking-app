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

ActiveRecord::Schema[7.1].define(version: 2024_05_14_042309) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "booking_types", force: :cascade do |t|
    t.uuid "uuid"
    t.string "name"
    t.string "color"
    t.integer "duration"
    t.integer "diary_uid"
    t.integer "entity_uid"
    t.integer "booking_uid"
    t.integer "booking_status_uid"
    t.string "bookable_type"
    t.bigint "bookable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bookable_type", "bookable_id"], name: "index_booking_types_on_bookable"
    t.index ["diary_uid", "booking_uid"], name: "index_booking_types_on_diary_uid_and_booking_uid"
  end

  create_table "bookings", force: :cascade do |t|
    t.text "reason"
    t.datetime "end_at"
    t.datetime "start_time"
    t.integer "duration"
    t.integer "debtor_id"
    t.integer "patient_id"
    t.bigint "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "uid"
    t.boolean "cancelled"
    t.uuid "uuid"
    t.integer "entity_uid"
    t.integer "booking_type_uid"
    t.integer "booking_status_uid"
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
    t.string "name"
    t.integer "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "disabled", default: true
    t.uuid "uuid"
    t.bigint "entity_id"
    t.integer "treating_doctor_uid"
    t.integer "booking_type_uid"
    t.json "booking_statuses"
    t.json "booking_types"
    t.integer "uid"
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

  add_foreign_key "debtors", "bookings"
  add_foreign_key "diaries", "bookings"
  add_foreign_key "patients", "bookings"
end
