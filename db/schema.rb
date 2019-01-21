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

ActiveRecord::Schema.define(version: 2019_01_21_204338) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.integer "birth_year"
    t.integer "dead_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "name"
    t.bigint "author_id"
    t.bigint "publisher_id"
    t.integer "publish_year"
    t.integer "rating"
    t.string "note"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "martinus_url"
    t.jsonb "martinus_data"
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["publisher_id"], name: "index_books_on_publisher_id"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "publishers", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishlists", force: :cascade do |t|
    t.string "name"
    t.bigint "author_id"
    t.bigint "publisher_id"
    t.integer "publish_year"
    t.string "martinus_url"
    t.string "image_url"
    t.string "note"
    t.integer "pages"
    t.string "price"
    t.string "expected_release"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_wishlists_on_author_id"
    t.index ["publisher_id"], name: "index_wishlists_on_publisher_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "books", "authors"
  add_foreign_key "books", "publishers"
  add_foreign_key "books", "users"
  add_foreign_key "wishlists", "authors"
  add_foreign_key "wishlists", "publishers"
  add_foreign_key "wishlists", "users"
end
