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

ActiveRecord::Schema.define(:version => 20130609123546) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.text     "raw_info"
    t.string   "provider"
    t.string   "token"
    t.string   "refresh_token"
    t.datetime "expires_at"
    t.string   "uid"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "entries", :force => true do |t|
    t.integer  "feed_id"
    t.string   "name"
    t.text     "summary"
    t.text     "url"
    t.datetime "published_at"
    t.string   "guid"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "author"
    t.text     "content"
  end

  create_table "feeds", :force => true do |t|
    t.text     "app_url"
    t.string   "entity_name"
    t.datetime "last_processed"
    t.datetime "last_requested_processing"
    t.string   "is_pending"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.datetime "rss_last_modified_at"
    t.text     "html_url"
  end

  create_table "my_entries", :force => true do |t|
    t.integer  "entry_id"
    t.integer  "user_id"
    t.boolean  "is_star"
    t.boolean  "is_to_read"
    t.datetime "last_clicked_on"
    t.text     "categories"
    t.datetime "last_starred_at"
    t.string   "current_star"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "my_feed_id"
    t.datetime "published_at"
  end

  create_table "my_feeds", :force => true do |t|
    t.integer  "user_id"
    t.integer  "feed_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "colour"
    t.text     "categories"
  end

  create_table "tag_entries", :force => true do |t|
    t.integer  "feed_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "my_feed_id"
  end

  create_table "tags", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "sort_id"
    t.integer  "sort_order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "unconfirmed_email"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "is_organization"
    t.string   "plan_genre"
    t.string   "name"
    t.boolean  "is_paying_customer"
    t.string   "username"
    t.string   "slug"
    t.text     "description"
  end

end
