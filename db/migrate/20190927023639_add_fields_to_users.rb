class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :university, :string, { :default => nil }
    add_column :users, :pending_approval, :boolean, { :default => false }
  end
end
