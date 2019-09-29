class Library < ApplicationRecord
  has_many :librarians

  has_many :contains
  has_many :books, through: :contains

  def self.get_lib_name(library_id)
    Library.select(:name).find_by(id: library_id).name
  end
end
