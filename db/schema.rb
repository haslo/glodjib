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

ActiveRecord::Schema.define(version: 20140101141806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flickr_images", force: true do |t|
    t.string   "image_title"
    t.text     "image_description"
    t.string   "aperture"
    t.string   "shutter"
    t.string   "iso"
    t.string   "focal_length"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "camera"
    t.string   "full_flickr_url"
    t.string   "flickr_id"
    t.datetime "date_taken"
    t.datetime "date_posted"
    t.string   "flickr_user"
  end

  create_table "galleries", force: true do |t|
    t.string   "title"
    t.string   "shorthand"
    t.boolean  "is_portfolio",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "custom_shorthand", default: false
    t.integer  "position"
    t.string   "special_usage"
    t.integer  "pending_updates",  default: 0,     null: false
  end

  create_table "galleries_images", force: true do |t|
    t.integer  "gallery_id"
    t.integer  "image_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_sizes", force: true do |t|
    t.integer  "linked_image_id"
    t.string   "label"
    t.integer  "width"
    t.integer  "height"
    t.string   "source"
    t.string   "url"
    t.string   "media"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "linked_image_type"
  end

  create_table "images", force: true do |t|
    t.string   "image_title"
    t.text     "image_description"
    t.string   "aperture"
    t.string   "shutter"
    t.string   "iso"
    t.string   "focal_length"
    t.string   "camera"
    t.datetime "date_taken"
    t.integer  "flickr_image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_comments", force: true do |t|
    t.integer  "post_id"
    t.string   "name"
    t.text     "comment"
    t.string   "email"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_spam",    default: false
    t.boolean  "is_deleted", default: false
  end

  create_table "post_tags", force: true do |t|
    t.string   "tag_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_tags_posts", id: false, force: true do |t|
    t.integer "post_id"
    t.integer "post_tag_id"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shorthand"
    t.boolean  "custom_shorthand", default: false
    t.boolean  "is_page",          default: false
  end

  create_table "queue_classic_jobs", force: true do |t|
    t.text     "q_name",    null: false
    t.text     "method",    null: false
    t.json     "args",      null: false
    t.datetime "locked_at"
  end

  add_index "queue_classic_jobs", ["q_name", "id"], name: "idx_qc_on_name_only_unlocked", where: "(locked_at IS NULL)", using: :btree

  create_table "settings", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
