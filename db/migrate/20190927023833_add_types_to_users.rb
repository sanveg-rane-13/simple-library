class AddTypesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, :default => false
    add_column :users, :student, :boolean, { :default => false }
    add_column :users, :librarian, :boolean, { :default => false }
  end
end
