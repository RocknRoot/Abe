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

ActiveRecord::Schema.define(:version => 20120704223213) do

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
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "approved",   :default => true
  end

  add_index "comments", ["term_id"], :name => "index_comments_on_term_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "terms", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "category_id"
    t.boolean  "public"
    t.binary   "content"
    t.string   "type"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "accept_comment", :default => true
  end

  add_index "terms", ["category_id"], :name => "index_terms_on_category_id"
  add_index "terms", ["user_id"], :name => "index_terms_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password"
    t.string   "salt"
    t.string   "email"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "time_zone"
    t.string   "password_reset_token"
    t.datetime "password_reset_time"
  end

end
