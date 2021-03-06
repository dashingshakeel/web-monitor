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

ActiveRecord::Schema.define(version: 20170730151153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "logs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "supervisor_id"
    t.integer  "service_id"
    t.string   "status"
    t.integer  "type_id"
    t.string   "response_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["service_id"], name: "index_logs_on_service_id", using: :btree
    t.index ["supervisor_id"], name: "index_logs_on_supervisor_id", using: :btree
    t.index ["type_id"], name: "index_logs_on_type_id", using: :btree
    t.index ["user_id"], name: "index_logs_on_user_id", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.integer  "type_id"
    t.integer  "supervisor_id"
    t.string   "port"
    t.integer  "duration"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["supervisor_id"], name: "index_services_on_supervisor_id", using: :btree
    t.index ["type_id"], name: "index_services_on_type_id", using: :btree
  end

  create_table "supervisors", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_supervisors_on_user_id", using: :btree
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "logs", "services"
  add_foreign_key "logs", "supervisors"
  add_foreign_key "logs", "types"
  add_foreign_key "logs", "users"
  add_foreign_key "services", "supervisors"
  add_foreign_key "services", "types"
  add_foreign_key "supervisors", "users"
end
