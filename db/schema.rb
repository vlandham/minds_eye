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

ActiveRecord::Schema.define(:version => 20080716133832) do

  create_table "flickr_searches", :force => true do |t|
    t.string   "search_parameter"
    t.string   "search_type"
    t.integer  "start_page"
    t.integer  "end_page"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_page",     :default => 0
    t.integer  "current_photo",    :default => 0
    t.integer  "photos_per_page"
    t.boolean  "completed",        :default => false
  end

  create_table "photos", :force => true do |t|
    t.integer  "flickr_id"
    t.datetime "taken_at"
    t.datetime "uploaded_at"
    t.text     "description"
    t.string   "title"
    t.integer  "license"
    t.string   "flickr_url"
    t.integer  "flickr_search_id"
    t.string   "image_filename"
    t.integer  "image_width"
    t.integer  "image_height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flickr_url_large"
    t.string   "flickr_url_medium"
    t.integer  "flickr_views"
    t.string   "cached_tag_list"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

end
