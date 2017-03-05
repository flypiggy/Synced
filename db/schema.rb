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

ActiveRecord::Schema.define(version: 20170304134453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "events", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",                    null: false
    t.text     "description"
    t.integer  "event_type",  default: 1, null: false
    t.integer  "status",      default: 0
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "short_name"
    t.index ["name"], name: "index_events_on_name", using: :btree
    t.index ["status"], name: "index_events_on_status", using: :btree
  end

  create_table "events_guests", force: :cascade do |t|
    t.uuid     "event_id"
    t.uuid     "guest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_events_guests_on_event_id", using: :btree
    t.index ["guest_id"], name: "index_events_guests_on_guest_id", using: :btree
  end

  create_table "guests", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "company"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "file"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["imageable_id", "imageable_type"], name: "index_images_on_imageable_id_and_imageable_type", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "email"
    t.string "password_digest", default: "", null: false
    t.string "username"
    t.string "mobile"
    t.string "roles",           default: [],              array: true
    t.string "city"
    t.string "company"
    t.string "title"
    t.string "avatar"
    t.string "bio"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["mobile"], name: "index_users_on_mobile", using: :btree
  end

  create_table "vote_items", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",                   null: false
    t.uuid     "vote_id",                null: false
    t.integer  "count",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["vote_id"], name: "index_vote_items_on_vote_id", using: :btree
  end

  create_table "votes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",                         null: false
    t.boolean  "enabled",      default: false, null: false
    t.string   "votable_type",                 null: false
    t.uuid     "votable_id",                   null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id", using: :btree
  end

end
