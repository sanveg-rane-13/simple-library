class CreateLibraryBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :library_books do |t|
      t.integer :count

      t.belongs_to :library
      t.belongs_to :book

      t.timestamps
    end
  end
end
