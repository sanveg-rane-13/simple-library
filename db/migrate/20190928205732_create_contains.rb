class CreateContains < ActiveRecord::Migration[6.0]
  def change
    create_table :contains do |t|
      t.integer :count

      t.belongs_to :library
      t.belongs_to :book

      t.timestamps
    end
  end
end
