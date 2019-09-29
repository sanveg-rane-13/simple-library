class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    # common attributes
    add_column :users, :name, :string

    # student attributes
    add_column :users, :university, :string, { :default => nil }

    # librarian attributes
    add_column :users, :pending_approval, :boolean, { :default => false }
  
  end
end
