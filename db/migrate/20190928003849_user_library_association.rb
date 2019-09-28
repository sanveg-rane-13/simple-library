class UserLibraryAssociation < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :library_id, :integer, { :default => nil }
  end
end
