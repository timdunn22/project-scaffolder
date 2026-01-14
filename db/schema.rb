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

ActiveRecord::Schema[8.1].define(version: 2026_01_13_203126) do
  create_table "generated_projects", force: :cascade do |t|
    t.json "config_choices"
    t.datetime "created_at", null: false
    t.integer "download_count"
    t.integer "template_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["template_id"], name: "index_generated_projects_on_template_id"
    t.index ["user_id"], name: "index_generated_projects_on_user_id"
  end

  create_table "templates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.json "file_structure"
    t.boolean "is_public"
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_templates_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "generated_projects", "templates"
  add_foreign_key "generated_projects", "users"
  add_foreign_key "templates", "users"
end
