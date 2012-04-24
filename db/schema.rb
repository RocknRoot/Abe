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

ActiveRecord::Schema.define(:version => 20120420141417) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"
  add_index "categories", ["user_id"], :name => "index_categories_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "term_id"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["term_id"], :name => "index_comments_on_term_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "term_notepads", :id => false, :force => true do |t|
    t.integer  "term_id",    :null => false
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "term_tags", :force => true do |t|
    t.integer  "term_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "term_tags", ["tag_id"], :name => "index_term_tags_on_tag_id"
  add_index "term_tags", ["term_id"], :name => "index_term_tags_on_term_id"

  create_table "terms", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "parent_id"
    t.boolean  "public"
    t.string   "type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "terms", ["category_id"], :name => "index_terms_on_category_id"
  add_index "terms", ["parent_id"], :name => "index_terms_on_parent_id"
  add_index "terms", ["user_id"], :name => "index_terms_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password"
    t.string   "salt"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
