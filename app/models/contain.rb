class Contain < ApplicationRecord
  belongs_to :library
  belongs_to :book

  validates_uniqueness_of :book_id, :scope => :library_id

  # get all books and count for the library
  def self.get_books_of_lib(library_id)
    Contain.where(library_id: library_id)
  end

  # get contains object from lib id and book id
  def self.get_lib_book(library_id, book_id)
    return Contain.where({ library_id: library_id, book_id: book_id }).first
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

  # reduce count when checked out
  def reduce_count
    count = self[:count]
    if (count > 0)
      self[:count] = count - 1
    end
  end

  # increase count when returned
  def increase_count
    self[:count] = self[:count] + 1
  end
end
