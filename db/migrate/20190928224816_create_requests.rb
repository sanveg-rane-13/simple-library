class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.datetime :start
      t.datetime :end
      t.boolean :special_approval
      t.datetime :hold
      t.boolean :bookmark
      t.integer :library_id

      t.belongs_to :student
      t.belongs_to :book
      
      t.timestamps
    end
  end
end
