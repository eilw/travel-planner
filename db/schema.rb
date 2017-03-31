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

ActiveRecord::Schema.define(version: 20170331120429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "text",             null: false
    t.datetime "added_at"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "author_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["author_id"], name: "index_comments_on_author_id", using: :btree
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  end

  create_table "trip_date_options", force: :cascade do |t|
    t.string   "range",      null: false
    t.integer  "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_trip_date_options_on_trip_id", using: :btree
  end

  create_table "trip_destinations", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.integer  "trip_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["trip_id"], name: "index_trip_destinations_on_trip_id", using: :btree
  end

  create_table "trip_invites", force: :cascade do |t|
    t.string   "email",        default: "", null: false
    t.integer  "trip_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "message"
    t.boolean  "rvsp"
    t.datetime "responded_at"
    t.string   "token"
    t.index ["token"], name: "index_trip_invites_on_token", unique: true, using: :btree
    t.index ["trip_id"], name: "index_trip_invites_on_trip_id", using: :btree
  end

  create_table "trip_participants", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_trip_participants_on_trip_id", using: :btree
    t.index ["user_id"], name: "index_trip_participants_on_user_id", using: :btree
  end

  create_table "trips", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_trips_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.boolean  "yay"
    t.boolean  "nay"
    t.string   "votable_type"
    t.integer  "votable_id"
    t.integer  "voter_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id", using: :btree
    t.index ["voter_id"], name: "index_votes_on_voter_id", using: :btree
  end

  add_foreign_key "trips", "users"
end
