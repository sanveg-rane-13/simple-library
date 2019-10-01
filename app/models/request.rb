class Request < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_uniqueness_of :book_id, :scope => :user_id

  # create new request object to persist
  # NOTE: persist the lib_book object as well
  def self.new_checkout_obj(lib_book, user_id)
    if lib_book.nil?
      return false
    end

    book = Book.find(lib_book.book_id)

    if book.is_special?
      # wait for librarian to approve special book
      return Request.new({ library_id: lib_book.library_id,
                           user_id: user_id,
                           book_id: lib_book.book_id,
                           special_approval: true })
    else
      # reduce count in library if book checked out
      lib_book.reduce_count
      return Request.new({ library_id: lib_book.library_id,
                          user_id: user_id,
                          book_id: lib_book.book_id,
                          start: Time.now })
    end
  end

  # get the request object to delete on return
  # NOTE: persist the lib_book object as well
  def self.new_return_obj(lib_book, user_id)
    if lib_book.nil?
      return false
    end

    request = Request.where({ library_id: lib_book.library_id,
                             user_id: user_id,
                             book_id: lib_book.book_id }).first
    if !request.nil?
      lib_book.increase_count
    end

    return request
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

  # check if the book is bookmarked by the user
  def self.is_bookmarked(lib_book, user_id)
    request = Request.where({ user_id: user_id,
                             library_id: lib_book.library_id,
                             book_id: lib_book.book_id }).where(bookmark: true)
    return !request.empty?
  end

  def self.get_request(lib_book, user_id)
    return Request.where({ user_id: user_id,
                          library_id: lib_book.library_id,
                          book_id: lib_book.book_id }).first
  end

  # get the string value of borrow date of a book
  def book_checkout_date
    start_date = self[:start]
    if !start_date.nil?
      return start_date.to_date.strftime("%b-%d-%Y")
    end
  end

  # get the string value of last date to return a book
  def book_return_date
    max_brw_days = Library.find(self[:library_id]).max_borrow_days
    start_date = self[:start]

    if !start_date.nil?
      last_date = start_date + max_brw_days.days
      return last_date.to_date.strftime("%b-%d-%Y")
    end
  end

  # if overdue return the total late fee
  def get_late_fee
    lib = Library.find(self[:library_id])
    max_brw_days = lib.max_borrow_days
    fine = lib.overdue_fine

    late_fee = 0
    start_date = self[:start]

    if !start_date.nil? && Time.now > start_date + max_brw_days.days
      overdue_days = (Time.now.to_date - (start_date + max_brw_days.days).to_date).to_i
      late_fee = fine * overdue_days
    end

    return late_fee
  end
end
