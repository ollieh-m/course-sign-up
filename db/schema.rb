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

ActiveRecord::Schema.define(version: 20160808150832) do

  create_table "admins", force: :cascade do |t|
    t.string   "email"
    t.string   "password_hash"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email"

  create_table "attendees", force: :cascade do |t|
    t.string   "email"
    t.date     "date_of_birth"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "attendees", ["email", "date_of_birth"], name: "index_attendees_on_email_and_date_of_birth"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "courses", ["end"], name: "index_courses_on_end"
  add_index "courses", ["name"], name: "index_courses_on_name"
  add_index "courses", ["start"], name: "index_courses_on_start"

  create_table "rsvps", force: :cascade do |t|
    t.integer  "attendee_id"
    t.integer  "course_id"
    t.string   "status"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "confirmation_token_hash"
  end

  add_index "rsvps", ["attendee_id"], name: "index_rsvps_on_attendee_id"
  add_index "rsvps", ["course_id"], name: "index_rsvps_on_course_id"
  add_index "rsvps", ["status"], name: "index_rsvps_on_status"

end
