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

ActiveRecord::Schema.define(version: 2019_04_08_083259) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "class_rooms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "picture"
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_class_rooms_on_teacher_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "name_student"
    t.string "content"
    t.bigint "lecture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lecture_id"], name: "index_comments_on_lecture_id"
  end

  create_table "lectures", force: :cascade do |t|
    t.string "name"
    t.bigint "teacher_id"
    t.bigint "professional_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "video_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["professional_id"], name: "index_lectures_on_professional_id"
    t.index ["teacher_id"], name: "index_lectures_on_teacher_id"
  end

  create_table "professionals", force: :cascade do |t|
    t.string "company"
    t.string "title"
    t.string "bio"
    t.string "location"
    t.string "linkedin"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_professionals_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "message"
    t.bigint "teacher_id"
    t.bigint "professional_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean "confirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["professional_id"], name: "index_requests_on_professional_id"
    t.index ["teacher_id"], name: "index_requests_on_teacher_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "teachers", force: :cascade do |t|
    t.string "school"
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "profile_picture"
    t.string "background_picture"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "class_rooms", "teachers"
  add_foreign_key "comments", "lectures"
  add_foreign_key "lectures", "professionals"
  add_foreign_key "lectures", "teachers"
  add_foreign_key "professionals", "users"
  add_foreign_key "requests", "professionals"
  add_foreign_key "requests", "teachers"
  add_foreign_key "teachers", "users"
end
