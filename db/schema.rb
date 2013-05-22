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

ActiveRecord::Schema.define(:version => 20130522223518) do

  create_table "flickr_caches", :force => true do |t|
    t.integer  "flickr_user_id"
    t.integer  "flickr_tag_id"
    t.datetime "timeout"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "flickr_images", :force => true do |t|
    t.string   "flickr_id"
    t.string   "image_title"
    t.text     "image_description"
    t.string   "aperture"
    t.string   "shutter"
    t.string   "iso"
    t.string   "focal_length"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "flickr_user_id"
    t.string   "camera"
    t.string   "full_flickr_url"
    t.string   "flickr_thumbnail_url"
  end

  create_table "flickr_images_flickr_tags", :id => false, :force => true do |t|
    t.integer "flickr_image_id"
    t.integer "flickr_tag_id"
  end

  create_table "flickr_tags", :force => true do |t|
    t.text     "tag_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "flickr_users", :force => true do |t|
    t.text     "username"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "post_comments", :force => true do |t|
    t.integer  "post_id"
    t.string   "name"
    t.text     "comment"
    t.string   "email"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "post_tags", :force => true do |t|
    t.string   "tag_text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "post_tags_posts", :id => false, :force => true do |t|
    t.integer "post_id"
    t.integer "post_tag_id"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "shorthand"
    t.boolean  "custom_shorthand", :default => false
  end

  create_table "settings", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
