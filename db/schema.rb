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

ActiveRecord::Schema.define(version: 20160903202903) do

  create_table "courtesies", force: :cascade do |t|
    t.string   "name"
    t.integer  "phone",      limit: 8
    t.string   "email"
    t.datetime "start_hour"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "event_name"
    t.string   "option_1"
    t.string   "option_2"
    t.string   "option_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.datetime "start_date"
    t.integer  "users_allowed"
    t.string   "name"
    t.integer  "users_enrolled"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.integer  "lessons"
    t.integer  "price"
    t.string   "start_hour"
    t.string   "end_hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "options"
    t.datetime "start_date"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.integer  "lessons"
    t.datetime "expiry_at"
    t.integer  "plan_id"
    t.boolean  "admin",                         default: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "phone",               limit: 8
    t.integer  "document",            limit: 8
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "last_login"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
