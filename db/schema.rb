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

ActiveRecord::Schema.define(version: 20160923084409) do

  create_table "exeo_japans", force: :cascade do |t|
    t.string   "event_url",                    limit: 255
    t.string   "main_image_url",               limit: 255
    t.string   "venue_name",                   limit: 255
    t.string   "postalcode",                   limit: 255
    t.string   "prefecture_name",              limit: 255
    t.string   "address",                      limit: 255
    t.datetime "event_date_time"
    t.string   "title",                        limit: 255
    t.text     "description",                  limit: 65535
    t.string   "reservation_state_for_male",   limit: 255
    t.string   "reservation_state_for_female", limit: 255
    t.string   "price_for_male",               limit: 255
    t.string   "price_for_female",             limit: 255
    t.string   "eligibility_for_male",         limit: 255
    t.string   "eligibility_for_female",       limit: 255
    t.string   "age_range_for_male",           limit: 255
    t.string   "age_range_for_female",         limit: 255
    t.text     "important_reminder",           limit: 65535
    t.text     "all_images_link",              limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "otokon_japans", force: :cascade do |t|
    t.string   "event_url",                    limit: 255
    t.string   "main_image_url",               limit: 255
    t.string   "venue_name",                   limit: 255
    t.string   "nearest_station",              limit: 255
    t.string   "postalcode",                   limit: 255
    t.string   "prefecture_name",              limit: 255
    t.string   "address",                      limit: 255
    t.datetime "event_date_time"
    t.string   "event_start_time",             limit: 255
    t.string   "event_end_time",               limit: 255
    t.string   "reception_time",               limit: 255
    t.string   "title",                        limit: 255
    t.text     "description",                  limit: 65535
    t.string   "target_people",                limit: 255
    t.string   "reservation_limit_for_male",   limit: 255
    t.string   "reservation_limit_for_female", limit: 255
    t.string   "reservation_state_for_male",   limit: 255
    t.string   "reservation_state_for_female", limit: 255
    t.string   "price_for_male",               limit: 255
    t.string   "price_for_female",             limit: 255
    t.string   "eligibility_for_all",          limit: 255
    t.string   "eligibility_for_male",         limit: 255
    t.string   "eligibility_for_female",       limit: 255
    t.string   "age_range_for_male",           limit: 255
    t.string   "age_range_for_female",         limit: 255
    t.text     "important_reminder",           limit: 65535
    t.text     "cancellation_policy",          limit: 65535
    t.text     "all_images_link",              limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "post_metas", id: false, force: :cascade do |t|
    t.integer "meta_id",    limit: 8,          default: 0, null: false
    t.integer "post_id",    limit: 8,          default: 0, null: false
    t.string  "meta_key",   limit: 255
    t.text    "meta_value", limit: 4294967295
  end

  create_table "posts", id: false, force: :cascade do |t|
    t.integer  "ID",                    limit: 8,          default: 0,         null: false
    t.integer  "post_author",           limit: 8,          default: 0,         null: false
    t.datetime "post_date",                                                    null: false
    t.datetime "post_date_gmt",                                                null: false
    t.text     "post_content",          limit: 4294967295,                     null: false
    t.text     "post_title",            limit: 65535,                          null: false
    t.text     "post_excerpt",          limit: 65535,                          null: false
    t.string   "post_status",           limit: 20,         default: "publish", null: false
    t.string   "comment_status",        limit: 20,         default: "open",    null: false
    t.string   "ping_status",           limit: 20,         default: "open",    null: false
    t.string   "post_password",         limit: 20,         default: "",        null: false
    t.string   "post_name",             limit: 200,        default: "",        null: false
    t.text     "to_ping",               limit: 65535,                          null: false
    t.text     "pinged",                limit: 65535,                          null: false
    t.datetime "post_modified",                                                null: false
    t.datetime "post_modified_gmt",                                            null: false
    t.text     "post_content_filtered", limit: 4294967295,                     null: false
    t.integer  "post_parent",           limit: 8,          default: 0,         null: false
    t.string   "guid",                  limit: 255,        default: "",        null: false
    t.integer  "menu_order",            limit: 4,          default: 0,         null: false
    t.string   "post_type",             limit: 20,         default: "post",    null: false
    t.string   "post_mime_type",        limit: 100,        default: "",        null: false
    t.integer  "comment_count",         limit: 8,          default: 0,         null: false
  end

end
