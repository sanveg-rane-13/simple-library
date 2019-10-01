class Request < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_uniqueness_of :book_id, :scope => :user_id

  # create new request object to persist
  def self.new_checkout_obj(lib_book, user_id)
    if lib_book.nil?
      return false
    end

    book = Book.find(lib_book.book_id)

    if book.is_special?
      return Request.new({ library_id: lib_book.library_id,
                           user_id: user_id,
                           book_id: lib_book.book_id,
                           special_approval: true })
    else
      return Request.new({ library_id: lib_book.library_id,
                          user_id: user_id,
                          book_id: lib_book.book_id,
                          start: Time.now })
    end
  end

  # check if current user has checked out the same book from same library
  def self.is_checked_out(lib_book, user_id)
    request = Request.where({ user_id: user_id,
                             library_id: lib_book.library_id,
                             book_id: lib_book.book_id }).where.not(start: nil)
    return !request.empty?
  end

  # check if the current user has hold on the same book from same library
  def self.is_on_hold(lib_book, user_id)
    request = Request.where({ user_id: user_id,
                             library_id: lib_book.library_id,
                             book_id: lib_book.book_id }).where.not(hold: nil)
    return !request.empty?
  end

  def self.is_bookmarked(lib_book, user_id)
    request = Request.where({ user_id: user_id,
                             library_id: lib_book.library_id,
                             book_id: lib_book.book_id }).where(bookmark: true)
    return !request.empty?
  end
end
