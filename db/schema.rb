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

ActiveRecord::Schema.define(:version => 20130513224043) do

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
    t.boolean  "is_in_portfolio"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "flickr_user_id"
  end

  create_table "flickr_images_flickr_tags", :force => true do |t|
    t.integer  "flickr_image_id"
    t.integer  "flickr_tag_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
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

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "shorthand"
    t.boolean  "custom_shorthand", :default => false
  end

end
