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

ActiveRecord::Schema.define(version: 2019_06_27_183327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "managers", force: :cascade do |t|
    t.string "company"
    t.integer "currency", default: 1, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_managers_on_user_id", unique: true
  end

  create_table "publishing_platforms", force: :cascade do |t|
    t.integer "name", null: false
    t.string "url", null: false
    t.string "username"
    t.string "password_digest"
    t.string "token"
    t.bigint "manager_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_publishing_platforms_on_manager_id"
    t.index ["name"], name: "index_publishing_platforms_on_name", unique: true
  end

  create_table "task_comments", force: :cascade do |t|
    t.text "comment"
    t.bigint "task_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_task_comments_on_task_id"
    t.index ["user_id"], name: "index_task_comments_on_user_id"
  end

  create_table "task_keywords", force: :cascade do |t|
    t.string "name", null: false
    t.integer "density", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_task_keywords_on_task_id"
  end

  create_table "task_statuses", force: :cascade do |t|
    t.integer "status", null: false
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_task_statuses_on_task_id"
    t.index ["user_id"], name: "index_task_statuses_on_user_id"
  end

  create_table "task_submissions", force: :cascade do |t|
    t.text "submission"
    t.boolean "is_submitted", default: false, null: false
    t.bigint "task_id", null: false
    t.bigint "writer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_task_submissions_on_task_id"
    t.index ["writer_id"], name: "index_task_submissions_on_writer_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "due_date", null: false
    t.integer "max_plagiarism"
    t.integer "max_mistakes"
    t.integer "min_word", default: 0, null: false
    t.integer "payment_type", null: false
    t.integer "payment_value", null: false
    t.bigint "user_id", null: false
    t.bigint "manager_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_tasks_on_manager_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "team_members", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "writer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_members_on_team_id"
    t.index ["writer_id"], name: "index_team_members_on_writer_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "manager_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_teams_on_manager_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.string "access_token", null: false
    t.integer "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "writers", force: :cascade do |t|
    t.integer "rate_per_word", default: 0, null: false
    t.bigint "user_id", null: false
    t.bigint "manager_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_writers_on_manager_id"
    t.index ["user_id"], name: "index_writers_on_user_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "managers", "users"
  add_foreign_key "publishing_platforms", "managers"
  add_foreign_key "task_comments", "tasks"
  add_foreign_key "task_comments", "users"
  add_foreign_key "task_keywords", "tasks"
  add_foreign_key "task_statuses", "tasks"
  add_foreign_key "task_statuses", "users"
  add_foreign_key "task_submissions", "tasks"
  add_foreign_key "task_submissions", "writers"
  add_foreign_key "tasks", "managers"
  add_foreign_key "tasks", "users"
  add_foreign_key "team_members", "teams"
  add_foreign_key "team_members", "writers"
  add_foreign_key "teams", "managers"
  add_foreign_key "writers", "managers"
  add_foreign_key "writers", "users"
end
