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

ActiveRecord::Schema.define(version: 2019_08_19_175352) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "message_thread_id"
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_thread_id"], name: "index_chats_on_message_thread_id"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "emails", force: :cascade do |t|
    t.bigint "user_id"
    t.string "subject"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "message_thread_id"
    t.index ["message_thread_id"], name: "index_emails_on_message_thread_id"
    t.index ["user_id"], name: "index_emails_on_user_id"
  end

  create_table "message_thread_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "message_thread_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "message_id"
    t.string "message_type"
    t.index ["message_thread_id"], name: "index_message_thread_users_on_message_thread_id"
    t.index ["user_id"], name: "index_message_thread_users_on_user_id"
  end

  create_table "message_threads", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_message_threads_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "chats", "message_threads"
  add_foreign_key "chats", "users"
  add_foreign_key "emails", "message_threads"
  add_foreign_key "emails", "users"
  add_foreign_key "message_thread_users", "message_threads"
  add_foreign_key "message_thread_users", "users"
  add_foreign_key "message_threads", "users"
end
