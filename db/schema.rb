# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_28_041305) do

  create_table "books", force: :cascade do |t|
    t.integer "isbn"
    t.string "title"
    t.string "author"
    t.string "subject"
    t.boolean "is_special"
    t.text "summary"
    t.string "image_front_cover"
    t.string "edition"
    t.datetime "published"
    t.string "language"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "university"
    t.string "location"
    t.integer "max_borrow_days"
    t.integer "overdue_fine"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "library_books", force: :cascade do |t|
    t.integer "count"
    t.integer "library_id"
    t.integer "book_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_library_books_on_book_id"
    t.index ["library_id"], name: "index_library_books_on_library_id"
  end

  create_table "requests", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.boolean "special_approval"
    t.datetime "hold"
    t.boolean "bookmark"
    t.integer "library_id"
    t.integer "student_id"
    t.integer "book_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_requests_on_book_id"
    t.index ["student_id"], name: "index_requests_on_student_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "university"
    t.boolean "pending_approval", default: false
    t.boolean "admin", default: false
    t.boolean "student", default: false
    t.boolean "librarian", default: false
    t.integer "library_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
