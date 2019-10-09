class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.integer :library_id

      t.belongs_to :user
      t.belongs_to :book

      t.timestamps
    end
  end
end
