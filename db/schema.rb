# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110601160526) do

  create_table "boxes", :force => true do |t|
    t.integer  "project_id"
    t.string   "serial"
    t.datetime "start_projected"
    t.datetime "end_projected"
    t.datetime "start_actual"
    t.datetime "plant_discharge"
    t.datetime "end_actual"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "number"
    t.datetime "start_projected"
    t.datetime "end_projected"
    t.datetime "start_actual"
    t.datetime "end_actual"
    t.integer  "box_count"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "punchlists", :force => true do |t|
    t.integer  "box_id"
    t.integer  "department_id"
    t.string   "material"
    t.text     "description"
    t.datetime "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
  end

  create_table "sessions", :force => true do |t|
    t.integer  "user_id"
    t.string   "session_hash"
    t.datetime "login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user"
    t.string   "password"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
