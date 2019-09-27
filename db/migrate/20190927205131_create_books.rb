class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.integer :isbn
      t.string :title
      t.string :author
      t.string :subject
      t.boolean :is_special
      t.text :summary
      t.string :image_front_cover
      t.string :edition
      t.datetime :published
      t.string :language

      t.timestamps
    end
  end
end
