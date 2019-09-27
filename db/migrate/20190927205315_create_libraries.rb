class CreateLibraries < ActiveRecord::Migration[6.0]
  def change
    create_table :libraries do |t|
      t.string :name
      t.string :university
      t.string :location
      t.integer :max_borrow_days
      t.integer :overdue_fine

      t.timestamps
    end
  end
end
