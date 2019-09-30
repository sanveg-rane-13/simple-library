class Contain < ApplicationRecord
  belongs_to :library
  belongs_to :book

  validates_uniqueness_of :book_id, :scope => :library_id

  # get all books and count for the library
  def self.get_books_of_lib(library_id)
    Contain.where(library_id: library_id)
  end

  # check if book is avaliable for checkout from a library
  def self.can_checkout(lib_book)
    contain = Contain.where({ library_id: lib_book.library_id, book_id: lib_book.book_id }).first
    if contain.nil?
      return false
    end

    return contain.count > 0 ? true : false
  end

  # check if book is avaliable for hold from a library
  def self.can_hold(lib_book)
    contain = Contain.where({ library_id: lib_book.library_id, book_id: lib_book.book_id }).first
    if contain.nil?
      return false
    end

    return contain.count == 0 ? true : false
  end
end
