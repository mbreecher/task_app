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

ActiveRecord::Schema.define(version: 20140116185904) do

  create_table "customers", force: true do |t|
    t.integer  "csm_id"
    t.string   "name"
    t.date     "start"
    t.date     "fiscal_ye"
    t.date     "next_per_end"
    t.date     "next_target"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "single_source"
    t.string   "note"
    t.string   "xbrl_service"
  end

  create_table "feeder_tasks", force: true do |t|
    t.string   "name"
    t.string   "instructions"
    t.string   "reference"
    t.integer  "offset"
    t.integer  "task_set_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_sets", force: true do |t|
    t.string   "name"
    t.integer  "csm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "instructions"
    t.string   "reference"
    t.integer  "offset"
    t.integer  "csm_id"
    t.integer  "customer_id"
    t.date     "due_date"
    t.boolean  "done",         default: false
    t.string   "note"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.boolean  "is_senior",       default: false
    t.integer  "senior"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
