# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_06_25_064959) do
  create_table "bullets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "display_order"
    t.integer "entry_id", null: false
    t.datetime "updated_at", null: false
    t.index ["entry_id"], name: "index_bullets_on_entry_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "company_name"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "full_name"
    t.text "message"
    t.datetime "updated_at", null: false
  end

  create_table "cvs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "github_url"
    t.string "name"
    t.text "summary"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "website_url"
    t.index ["user_id"], name: "index_cvs_on_user_id"
  end

  create_table "entries", force: :cascade do |t|
    t.text "blurb"
    t.datetime "created_at", null: false
    t.string "date_text"
    t.integer "display_order"
    t.date "end_date"
    t.string "meta"
    t.integer "section_id", null: false
    t.date "start_date"
    t.string "subtitle"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_entries_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "cv_id", null: false
    t.integer "display_order"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["cv_id"], name: "index_sections_on_cv_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "tag_id", null: false
    t.integer "taggable_id", null: false
    t.string "taggable_type", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "bullets", "entries"
  add_foreign_key "cvs", "users"
  add_foreign_key "entries", "sections"
  add_foreign_key "sections", "cvs"
  add_foreign_key "sessions", "users"
  add_foreign_key "taggings", "tags"
end
