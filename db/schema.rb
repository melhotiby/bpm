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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130522235341) do

  create_table "calculations", :force => true do |t|
    t.integer  "session_id"
    t.integer  "zone1_duration"
    t.integer  "zone2_duration"
    t.integer  "zone3_duration"
    t.integer  "zone4_duration"
    t.integer  "average_bpm"
    t.integer  "max_bpm"
    t.integer  "min_bpm"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "calculations", ["session_id"], :name => "index_calculations_on_session_id"

  create_table "hrm_data_points", :force => true do |t|
    t.integer  "session_id"
    t.integer  "bpm"
    t.datetime "reading_start_time"
    t.datetime "reading_end_time"
    t.integer  "duration"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "zone"
  end

  add_index "hrm_data_points", ["session_id"], :name => "index_hrm_data_points_on_session_id"

  create_table "sessions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "duration"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["created_at"], :name => "index_sessions_on_created_at"
  add_index "sessions", ["id"], :name => "index_sessions_on_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "gender"
    t.integer  "age"
    t.integer  "hr_zone1_min"
    t.integer  "hr_zone1_max"
    t.integer  "hr_zone2_min"
    t.integer  "hr_zone2_max"
    t.integer  "hr_zone3_min"
    t.integer  "hr_zone3_max"
    t.integer  "hr_zone4_min"
    t.integer  "hr_zone4_max"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
