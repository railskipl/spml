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

ActiveRecord::Schema.define(version: 20140114050038) do

  create_table "consumer_spmls", force: true do |t|
    t.string   "computer_no"
    t.string   "cons_cd"
    t.string   "cons_no"
    t.string   "account_no"
    t.string   "category"
    t.string   "name"
    t.string   "addr1"
    t.string   "addr2"
    t.string   "pole_no"
    t.string   "meter_no"
    t.string   "meter_capacity"
    t.string   "connected_load"
    t.string   "connection_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consumers", force: true do |t|
    t.string   "pc"
    t.string   "bu"
    t.string   "consno"
    t.string   "disc_tag"
    t.string   "tag2"
    t.string   "yymm1"
    t.string   "yymm2"
    t.string   "mtr1"
    t.string   "mt1dgt"
    t.string   "mf1"
    t.string   "avgc1"
    t.string   "mtr1st"
    t.string   "rdng1"
    t.string   "rdmm1"
    t.string   "mtr2"
    t.string   "mt2dgt"
    t.string   "mf2"
    t.string   "avgc2"
    t.string   "mtr2st"
    t.string   "rdng2"
    t.string   "rdmm2"
    t.string   "heatcon"
    t.string   "oldcon"
    t.string   "poleno"
    t.string   "mrc"
    t.string   "route"
    t.string   "seq"
    t.string   "name"
    t.string   "addrs"
    t.string   "city"
    t.string   "pincode"
    t.string   "dtc"
    t.string   "trf"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "dtc_staffs", force: true do |t|
    t.string   "sub_cluster"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cluster_id"
  end

  create_table "meter_reader_statuses", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meter_status_id"
  end

  create_table "meter_statuses", force: true do |t|
    t.string   "billing_meter_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mobile_devises", force: true do |t|
    t.string   "imei"
    t.string   "manufacturer_name"
    t.date     "purchase_date"
    t.string   "phone_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mobileusers", force: true do |t|
    t.integer  "user_id"
    t.string   "imei"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mr_consumers", force: true do |t|
    t.string   "computer_no"
    t.string   "name"
    t.string   "conn_add1"
    t.string   "conn_add2"
    t.string   "cons_code"
    t.string   "meter_no"
    t.string   "sub_cluster"
    t.string   "walking_seq_no"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cons_no"
    t.boolean  "status",         default: false
    t.string   "account_no"
    t.string   "cluster_id"
  end

  create_table "readings", force: true do |t|
    t.float    "meter_reading"
    t.string   "consumer_no"
    t.string   "meter_status"
    t.datetime "date_time"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "ime_no"
    t.string   "image"
    t.string   "old_meter_no"
    t.string   "new_meter_no"
    t.string   "bill_month"
    t.string   "consumer_name"
    t.string   "reader_mobile_no"
    t.string   "meter_reader_status"
    t.text     "remark"
    t.string   "read_by"
    t.string   "consumer_status"
    t.string   "walking_seq_no"
    t.integer  "user_id"
    t.string   "cons_code"
    t.string   "computer_no"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",              default: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.binary   "img"
    t.string   "sub_cluster"
    t.string   "conn_add1"
    t.string   "conn_add2"
    t.string   "account_no"
    t.string   "cluster_id"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_users", force: true do |t|
    t.integer  "team_id"
    t.integer  "user_role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "teams", force: true do |t|
    t.string   "team_name"
    t.integer  "user_role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "user_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "is_admin",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.string   "email"
    t.string   "mobile_no"
  end

end
