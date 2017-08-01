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

ActiveRecord::Schema.define(version: 20170801043822) do

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

  create_table "ot_jinzai_banks", force: :cascade do |t|
    t.string   "page_url",            limit: 255
    t.string   "calendar_date",       limit: 255
    t.string   "title",               limit: 255
    t.string   "sub_title",           limit: 255
    t.text     "job_feature",         limit: 65535
    t.text     "salary",              limit: 65535
    t.string   "working_hours",       limit: 255
    t.text     "holiday_vacation",    limit: 65535
    t.text     "job_category",        limit: 65535
    t.text     "employment_type",     limit: 65535
    t.text     "job_detail",          limit: 65535
    t.text     "recommended_comment", limit: 65535
    t.text     "workplace_feature",   limit: 65535
    t.string   "corporate_name",      limit: 255
    t.string   "office_name",         limit: 255
    t.string   "institution_type",    limit: 255
    t.string   "postalcode",          limit: 255
    t.string   "prefecture",          limit: 255
    t.text     "work_location",       limit: 65535
    t.text     "nearest_station",     limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "otokon_japans", force: :cascade do |t|
    t.string   "event_url",                    limit: 255
    t.string   "main_image_url",               limit: 255
    t.string   "venue_name",                   limit: 255
    t.string   "nearest_station",              limit: 255
    t.string   "postalcode",                   limit: 255
    t.string   "prefecture_name",              limit: 255
    t.string   "address",                      limit: 255
    t.text     "access",                       limit: 65535
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

  create_table "party_japans", force: :cascade do |t|
    t.string   "event_url",                    limit: 255
    t.string   "main_image_url",               limit: 255
    t.string   "venue_name",                   limit: 255
    t.string   "postalcode",                   limit: 255
    t.string   "prefecture_name",              limit: 255
    t.string   "address",                      limit: 255
    t.string   "nearest_station",              limit: 255
    t.string   "contact_info",                 limit: 255
    t.string   "gathering_place",              limit: 255
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
    t.string   "personal_document",            limit: 255
    t.string   "food_drink",                   limit: 255
    t.string   "event_dress_code",             limit: 255
    t.string   "cancellation_deadline",        limit: 255
    t.text     "important_reminder",           limit: 65535
    t.text     "all_images_link",              limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "ptot_jinzai_banks", force: :cascade do |t|
    t.string   "page_url",            limit: 255
    t.string   "calendar_date",       limit: 255
    t.string   "title",               limit: 255
    t.string   "sub_title",           limit: 255
    t.text     "job_feature",         limit: 65535
    t.text     "salary",              limit: 65535
    t.string   "working_hours",       limit: 255
    t.text     "holiday_vacation",    limit: 65535
    t.text     "job_category",        limit: 65535
    t.text     "employment_type",     limit: 65535
    t.text     "job_detail",          limit: 65535
    t.text     "recommended_comment", limit: 65535
    t.text     "workplace_feature",   limit: 65535
    t.string   "corporate_name",      limit: 255
    t.string   "office_name",         limit: 255
    t.string   "institution_type",    limit: 255
    t.string   "postalcode",          limit: 255
    t.string   "prefecture",          limit: 255
    t.text     "work_location",       limit: 65535
    t.text     "nearest_station",     limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "st_jinzai_banks", force: :cascade do |t|
    t.string   "page_url",            limit: 255
    t.string   "calendar_date",       limit: 255
    t.string   "title",               limit: 255
    t.string   "sub_title",           limit: 255
    t.text     "job_feature",         limit: 65535
    t.text     "salary",              limit: 65535
    t.string   "working_hours",       limit: 255
    t.text     "holiday_vacation",    limit: 65535
    t.text     "job_category",        limit: 65535
    t.text     "employment_type",     limit: 65535
    t.text     "job_detail",          limit: 65535
    t.text     "recommended_comment", limit: 65535
    t.text     "workplace_feature",   limit: 65535
    t.string   "corporate_name",      limit: 255
    t.string   "office_name",         limit: 255
    t.string   "institution_type",    limit: 255
    t.string   "postalcode",          limit: 255
    t.string   "prefecture",          limit: 255
    t.text     "work_location",       limit: 65535
    t.text     "nearest_station",     limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "wpf0c254blog_versions", primary_key: "blog_id", force: :cascade do |t|
    t.string   "db_version",   limit: 20, default: "", null: false
    t.datetime "last_updated",                         null: false
  end

  add_index "wpf0c254blog_versions", ["db_version"], name: "db_version", using: :btree

  create_table "wpf0c254blogs", primary_key: "blog_id", force: :cascade do |t|
    t.integer  "site_id",      limit: 8,   default: 0,  null: false
    t.string   "domain",       limit: 200, default: "", null: false
    t.string   "path",         limit: 100, default: "", null: false
    t.datetime "registered",                            null: false
    t.datetime "last_updated",                          null: false
    t.integer  "public",       limit: 1,   default: 1,  null: false
    t.integer  "archived",     limit: 1,   default: 0,  null: false
    t.integer  "mature",       limit: 1,   default: 0,  null: false
    t.integer  "spam",         limit: 1,   default: 0,  null: false
    t.integer  "deleted",      limit: 1,   default: 0,  null: false
    t.integer  "lang_id",      limit: 4,   default: 0,  null: false
  end

  add_index "wpf0c254blogs", ["domain", "path"], name: "domain", length: {"domain"=>50, "path"=>5}, using: :btree
  add_index "wpf0c254blogs", ["lang_id"], name: "lang_id", using: :btree

  create_table "wpf0c254commentmeta", primary_key: "meta_id", force: :cascade do |t|
    t.integer "comment_id", limit: 8,          default: 0, null: false
    t.string  "meta_key",   limit: 255
    t.text    "meta_value", limit: 4294967295
  end

  add_index "wpf0c254commentmeta", ["comment_id"], name: "comment_id", using: :btree
  add_index "wpf0c254commentmeta", ["meta_key"], name: "meta_key", length: {"meta_key"=>191}, using: :btree

  create_table "wpf0c254comments", primary_key: "comment_ID", force: :cascade do |t|
    t.integer  "comment_post_ID",      limit: 8,     default: 0,   null: false
    t.text     "comment_author",       limit: 255,                 null: false
    t.string   "comment_author_email", limit: 100,   default: "",  null: false
    t.string   "comment_author_url",   limit: 200,   default: "",  null: false
    t.string   "comment_author_IP",    limit: 100,   default: "",  null: false
    t.datetime "comment_date",                                     null: false
    t.datetime "comment_date_gmt",                                 null: false
    t.text     "comment_content",      limit: 65535,               null: false
    t.integer  "comment_karma",        limit: 4,     default: 0,   null: false
    t.string   "comment_approved",     limit: 20,    default: "1", null: false
    t.string   "comment_agent",        limit: 255,   default: "",  null: false
    t.string   "comment_type",         limit: 20,    default: "",  null: false
    t.integer  "comment_parent",       limit: 8,     default: 0,   null: false
    t.integer  "user_id",              limit: 8,     default: 0,   null: false
  end

  add_index "wpf0c254comments", ["comment_approved", "comment_date_gmt"], name: "comment_approved_date_gmt", using: :btree
  add_index "wpf0c254comments", ["comment_author_email"], name: "comment_author_email", length: {"comment_author_email"=>10}, using: :btree
  add_index "wpf0c254comments", ["comment_date_gmt"], name: "comment_date_gmt", using: :btree
  add_index "wpf0c254comments", ["comment_parent"], name: "comment_parent", using: :btree
  add_index "wpf0c254comments", ["comment_post_ID"], name: "comment_post_ID", using: :btree

  create_table "wpf0c254ewwwio_images", id: false, force: :cascade do |t|
    t.integer  "id",         limit: 3,     null: false
    t.text     "path",       limit: 65535, null: false
    t.string   "results",    limit: 55,    null: false
    t.integer  "image_size", limit: 4
    t.integer  "orig_size",  limit: 4
    t.integer  "updates",    limit: 4
    t.datetime "updated",                  null: false
    t.binary   "trace",      limit: 65535
  end

  add_index "wpf0c254ewwwio_images", ["id"], name: "id", unique: true, using: :btree
  add_index "wpf0c254ewwwio_images", ["path", "image_size"], name: "path_image_size", length: {"path"=>255, "image_size"=>nil}, using: :btree

  create_table "wpf0c254links", primary_key: "link_id", force: :cascade do |t|
    t.string   "link_url",         limit: 255,      default: "",  null: false
    t.string   "link_name",        limit: 255,      default: "",  null: false
    t.string   "link_image",       limit: 255,      default: "",  null: false
    t.string   "link_target",      limit: 25,       default: "",  null: false
    t.string   "link_description", limit: 255,      default: "",  null: false
    t.string   "link_visible",     limit: 20,       default: "Y", null: false
    t.integer  "link_owner",       limit: 8,        default: 1,   null: false
    t.integer  "link_rating",      limit: 4,        default: 0,   null: false
    t.datetime "link_updated",                                    null: false
    t.string   "link_rel",         limit: 255,      default: "",  null: false
    t.text     "link_notes",       limit: 16777215,               null: false
    t.string   "link_rss",         limit: 255,      default: "",  null: false
  end

  add_index "wpf0c254links", ["link_visible"], name: "link_visible", using: :btree

  create_table "wpf0c254options", primary_key: "option_id", force: :cascade do |t|
    t.string "option_name",  limit: 191,        default: "",    null: false
    t.text   "option_value", limit: 4294967295,                 null: false
    t.string "autoload",     limit: 20,         default: "yes", null: false
  end

  add_index "wpf0c254options", ["option_name"], name: "option_name", unique: true, using: :btree

  create_table "wpf0c254postmeta", primary_key: "meta_id", force: :cascade do |t|
    t.integer "post_id",    limit: 8,          default: 0, null: false
    t.string  "meta_key",   limit: 255
    t.text    "meta_value", limit: 4294967295
  end

  add_index "wpf0c254postmeta", ["meta_key"], name: "meta_key", length: {"meta_key"=>191}, using: :btree
  add_index "wpf0c254postmeta", ["post_id"], name: "post_id", using: :btree

  create_table "wpf0c254posts", primary_key: "ID", force: :cascade do |t|
    t.integer  "post_author",           limit: 8,          default: 0,         null: false
    t.datetime "post_date"
    t.datetime "post_date_gmt"
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
    t.datetime "post_modified"
    t.datetime "post_modified_gmt"
    t.text     "post_content_filtered", limit: 4294967295,                     null: false
    t.integer  "post_parent",           limit: 8,          default: 0,         null: false
    t.string   "guid",                  limit: 255,        default: "",        null: false
    t.integer  "menu_order",            limit: 4,          default: 0,         null: false
    t.string   "post_type",             limit: 20,         default: "post",    null: false
    t.string   "post_mime_type",        limit: 100,        default: "",        null: false
    t.integer  "comment_count",         limit: 8,          default: 0,         null: false
    t.string   "parent_type",           limit: 255
    t.integer  "parent_id",             limit: 4
  end

  add_index "wpf0c254posts", ["post_author"], name: "post_author", using: :btree
  add_index "wpf0c254posts", ["post_name"], name: "post_name", length: {"post_name"=>191}, using: :btree
  add_index "wpf0c254posts", ["post_parent"], name: "post_parent", using: :btree
  add_index "wpf0c254posts", ["post_type", "post_status", "post_date", "ID"], name: "type_status_date", using: :btree

  create_table "wpf0c254registration_log", primary_key: "ID", force: :cascade do |t|
    t.string   "email",           limit: 255, default: "", null: false
    t.string   "IP",              limit: 30,  default: "", null: false
    t.integer  "blog_id",         limit: 8,   default: 0,  null: false
    t.datetime "date_registered",                          null: false
  end

  add_index "wpf0c254registration_log", ["IP"], name: "IP", using: :btree

  create_table "wpf0c254signups", primary_key: "signup_id", force: :cascade do |t|
    t.string   "domain",         limit: 200,        default: "",    null: false
    t.string   "path",           limit: 100,        default: "",    null: false
    t.text     "title",          limit: 4294967295,                 null: false
    t.string   "user_login",     limit: 60,         default: "",    null: false
    t.string   "user_email",     limit: 100,        default: "",    null: false
    t.datetime "registered",                                        null: false
    t.datetime "activated",                                         null: false
    t.boolean  "active",                            default: false, null: false
    t.string   "activation_key", limit: 50,         default: "",    null: false
    t.text     "meta",           limit: 4294967295
  end

  add_index "wpf0c254signups", ["activation_key"], name: "activation_key", using: :btree
  add_index "wpf0c254signups", ["domain", "path"], name: "domain_path", length: {"domain"=>140, "path"=>51}, using: :btree
  add_index "wpf0c254signups", ["user_email"], name: "user_email", using: :btree
  add_index "wpf0c254signups", ["user_login", "user_email"], name: "user_login_email", using: :btree

  create_table "wpf0c254site", force: :cascade do |t|
    t.string "domain", limit: 200, default: "", null: false
    t.string "path",   limit: 100, default: "", null: false
  end

  add_index "wpf0c254site", ["domain", "path"], name: "domain", length: {"domain"=>140, "path"=>51}, using: :btree

  create_table "wpf0c254sitemeta", primary_key: "meta_id", force: :cascade do |t|
    t.integer "site_id",    limit: 8,          default: 0, null: false
    t.string  "meta_key",   limit: 255
    t.text    "meta_value", limit: 4294967295
  end

  add_index "wpf0c254sitemeta", ["meta_key"], name: "meta_key", length: {"meta_key"=>191}, using: :btree
  add_index "wpf0c254sitemeta", ["site_id"], name: "site_id", using: :btree

  create_table "wpf0c254term_relationships", id: false, force: :cascade do |t|
    t.integer "object_id",        limit: 8, default: 0, null: false
    t.integer "term_taxonomy_id", limit: 8, default: 0, null: false
    t.integer "term_order",       limit: 4, default: 0, null: false
  end

  add_index "wpf0c254term_relationships", ["term_taxonomy_id"], name: "term_taxonomy_id", using: :btree

  create_table "wpf0c254term_taxonomy", primary_key: "term_taxonomy_id", force: :cascade do |t|
    t.integer "term_id",     limit: 8,          default: 0,  null: false
    t.string  "taxonomy",    limit: 32,         default: "", null: false
    t.text    "description", limit: 4294967295,              null: false
    t.integer "parent",      limit: 8,          default: 0,  null: false
    t.integer "count",       limit: 8,          default: 0,  null: false
  end

  add_index "wpf0c254term_taxonomy", ["taxonomy"], name: "taxonomy", using: :btree
  add_index "wpf0c254term_taxonomy", ["term_id", "taxonomy"], name: "term_id_taxonomy", unique: true, using: :btree

  create_table "wpf0c254termmeta", primary_key: "meta_id", force: :cascade do |t|
    t.integer "term_id",    limit: 8,          default: 0, null: false
    t.string  "meta_key",   limit: 255
    t.text    "meta_value", limit: 4294967295
  end

  add_index "wpf0c254termmeta", ["meta_key"], name: "meta_key", length: {"meta_key"=>191}, using: :btree
  add_index "wpf0c254termmeta", ["term_id"], name: "term_id", using: :btree

  create_table "wpf0c254terms", primary_key: "term_id", force: :cascade do |t|
    t.string  "name",       limit: 200, default: "", null: false
    t.string  "slug",       limit: 200, default: "", null: false
    t.integer "term_group", limit: 8,   default: 0,  null: false
  end

  add_index "wpf0c254terms", ["name"], name: "name", length: {"name"=>191}, using: :btree
  add_index "wpf0c254terms", ["slug"], name: "slug", length: {"slug"=>191}, using: :btree

  create_table "wpf0c254usermeta", primary_key: "umeta_id", force: :cascade do |t|
    t.integer "user_id",    limit: 8,          default: 0, null: false
    t.string  "meta_key",   limit: 255
    t.text    "meta_value", limit: 4294967295
  end

  add_index "wpf0c254usermeta", ["meta_key"], name: "meta_key", length: {"meta_key"=>191}, using: :btree
  add_index "wpf0c254usermeta", ["user_id"], name: "user_id", using: :btree

  create_table "wpf0c254users", primary_key: "ID", force: :cascade do |t|
    t.string   "user_login",          limit: 60,  default: "", null: false
    t.string   "user_pass",           limit: 255, default: "", null: false
    t.string   "user_nicename",       limit: 50,  default: "", null: false
    t.string   "user_email",          limit: 100, default: "", null: false
    t.string   "user_url",            limit: 100, default: "", null: false
    t.datetime "user_registered",                              null: false
    t.string   "user_activation_key", limit: 255, default: "", null: false
    t.integer  "user_status",         limit: 4,   default: 0,  null: false
    t.string   "display_name",        limit: 250, default: "", null: false
    t.integer  "spam",                limit: 1,   default: 0,  null: false
    t.integer  "deleted",             limit: 1,   default: 0,  null: false
  end

  add_index "wpf0c254users", ["user_email"], name: "user_email", using: :btree
  add_index "wpf0c254users", ["user_login"], name: "user_login_key", using: :btree
  add_index "wpf0c254users", ["user_nicename"], name: "user_nicename", using: :btree

  create_table "youbrides", force: :cascade do |t|
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
    t.string   "reservation_limit_for_male",   limit: 255
    t.string   "reservation_limit_for_female", limit: 255
    t.string   "reservation_state_for_male",   limit: 255
    t.string   "reservation_state_for_female", limit: 255
    t.string   "price_for_male",               limit: 255
    t.string   "price_for_female",             limit: 255
    t.string   "age_range_for_male",           limit: 255
    t.string   "age_range_for_female",         limit: 255
    t.string   "eligibility_for_male",         limit: 255
    t.string   "eligibility_for_female",       limit: 255
    t.text     "cancellation_policy",          limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

end
