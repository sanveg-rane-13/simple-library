class Contain < ApplicationRecord
  belongs_to :library
  belongs_to :book

  validates_uniqueness_of :book_id, :scope => :library_id

  # get all books and count for the library
  def self.get_books_of_lib(library_id)
    Contain.where(library_id: library_id)
  end
end
