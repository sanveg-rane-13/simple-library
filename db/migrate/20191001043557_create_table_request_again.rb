class CreateTableRequestAgain < ActiveRecord::Migration[6.0]
  def change
    create_table "requests", force: :cascade do |t|
      t.datetime "start"
      t.datetime "end"
      t.boolean "special_approval"
      t.datetime "hold"
      t.boolean "bookmark"
      t.integer "library_id"
      t.integer "user_id"
      t.integer "book_id"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["book_id"], name: "index_requests_on_book_id"
      t.index ["user_id"], name: "index_requests_on_user_id"
    end
  end
end
