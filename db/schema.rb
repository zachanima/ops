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

ActiveRecord::Schema.define(:version => 20120623153157) do

  create_table "activities", :force => true do |t|
    t.integer  "operation_id"
    t.integer  "pilot_id"
    t.boolean  "prepared"
    t.boolean  "operated"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "activities", ["operation_id"], :name => "index_activities_on_operation_id"
  add_index "activities", ["pilot_id"], :name => "index_activities_on_pilot_id"

  create_table "drops", :force => true do |t|
    t.integer  "item_id"
    t.integer  "operation_id"
    t.integer  "quantity"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "drops", ["item_id"], :name => "index_drops_on_item_id"
  add_index "drops", ["operation_id"], :name => "index_drops_on_operation_id"

  create_table "items", :force => true do |t|
    t.integer  "type_id"
    t.string   "name"
    t.float    "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
  end

  create_table "items_sites", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "site_id"
  end

  create_table "operations", :force => true do |t|
    t.integer  "site_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "operations", ["site_id"], :name => "index_operations_on_site_id"

  create_table "pilots", :force => true do |t|
    t.string "name"
  end

  create_table "sites", :force => true do |t|
    t.string  "name"
    t.integer "image_id"
  end

end
