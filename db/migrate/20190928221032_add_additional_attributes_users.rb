class AddAdditionalAttributesUsers < ActiveRecord::Migration[6.0]
  def change
    #for student
    add_column :users, :study_level, :string, { :default => nil }

    #for librarian
    add_column :users, :library, :string, { :default => nil }
  end
end
