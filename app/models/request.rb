class Request < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_uniqueness_of :book_id, :scope => [:user_id, :start]

  # ========= Methods to create or update Requests ===========
  # create new request object to persist
  # NOTE: persist the lib_book object as well
  def self.new_checkout_obj(lib_book, user_id)
    book = Book.find(lib_book.book_id)

    if book.is_special?
      # wait for librarian to approve special book
      return Request.new({library_id: lib_book.library_id,
                          user_id: user_id,
                          book_id: lib_book.book_id,
                          special_approval: true})
    else
      # reduce count in library if book checked out
      lib_book.reduce_count
      return Request.new({library_id: lib_book.library_id,
                          user_id: user_id,
                          book_id: lib_book.book_id,
                          special_approval: false,
                          start: Time.now})
    end
  end

  # get the request object to delete on return
  # NOTE: persist the lib_book object as well
  def self.get_return_request_obj(lib_book, user_id)
    request = Request.where({library_id: lib_book.library_id,
                             user_id: user_id,
                             book_id: lib_book.book_id})
                  .where(end: nil).where.not(start: nil).first
    if !request.nil?
      lib_book.increase_count
      request.end = Time.now
    end

    return request
  end

  # get the request object to put on hold
  def self.new_hold_request_object(lib_book, user_id)
    return Request.new({library_id: lib_book.library_id,
                        user_id: user_id,
                        book_id: lib_book.book_id,
                        hold: Time.now})
  end

  # get the request object to delete a hold request
  def self.new_cancel_hold_request_object(lib_book, user_id)
    return Request.where({library_id: lib_book.library_id,
                          user_id: user_id,
                          book_id: lib_book.book_id}).where.not(hold: nil).first
  end

  # ========= Methods check existing Requests ===========

  # check if current user has checked out the same book from same library
  def self.is_checked_out(lib_book, user_id)
    request = Request.where({user_id: user_id,
                             library_id: lib_book.library_id,
                             book_id: lib_book.book_id}).where({end: nil, special_approval: false}).where.not(start: nil)

    return !request.empty?
  end

  # check if the current user has hold on the same book from same library
  def self.is_on_hold(lib_book, user_id)
    request = Request.where({user_id: user_id,
                             library_id: lib_book.library_id,
                             book_id: lib_book.book_id}).where.not(hold: nil)
    return !request.empty?
  end

  # check if the book is bookmarked by the user
  def self.is_bookmarked(lib_book, user_id)
    request = Request.where({user_id: user_id,
                             library_id: lib_book.library_id,
                             book_id: lib_book.book_id}).where(bookmark: true)
    return !request.empty?
  end

  def self.is_special_approval_pending(lib_book, user_id)
    request = Request.where({user_id: user_id,
                             library_id: lib_book.library_id,
                             book_id: lib_book.book_id}).where(special_approval: true)
    return !request.empty?
  end

  # get the hold count for particular book
  def self.get_hold_count(lib_book)
    return Request.where({library_id: lib_book.library_id,
                          book_id: lib_book.book_id})
               .where.not(hold: nil).count
  end

  def self.get_special_approvals_from_lib(library_id)
    return Request.where({library_id: library_id, special_approval: true})
  end

  # get particular request object
  def self.get_request(lib_book, user_id)
    return Request.where({user_id: user_id,
                          library_id: lib_book.library_id,
                          book_id: lib_book.book_id}).first
  end

  def self.get_all_holds_for_lib(library_id)
    return Request.where(library_id: library_id).where.not(hold: nil)
  end

  def self.get_first_hold_user(lib_book)
    return Request.where(library_id: lib_book.library_id, book_id: lib_book.book_id)
               .where.not(hold: nil)
               .order(:hold).first
  end

  # return all checked out requests of the user
  def self.get_all_checked_out(user_id)
    requests = Request.where({user_id: user_id}).where({end: nil, special_approval: false}).where.not(start: nil)
    return requests
  end

  # ========= Instance methods ===========

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

  # get status of the book
  def get_status_message
    message = ""

    # if book is checked out and returned
    if (!self[:start].nil? && !self[:end].nil?)
      return message.concat("Returned on ").concat(self[:end].to_date.strftime("%b-%d-%Y"))
    end

    # if book is checked out
    if (!self[:start].nil? && self[:end].nil?)
      return message.concat("Checked out on ")
                 .concat(self[:start].to_date.strftime("%b-%d-%Y"))
                 .concat(" - Return Date: ")
                 .concat(self.book_return_date)
    end

    # if book is pending special approval
    if (self[:special_approval])
      return message.concat("Waiting Librarian approval for checkout")
    end

    # if book is set on hold
    if (!self[:hold].nil?)
      return message.concat("Book on hold")
    end
  end

  # change status of book from hold to checked_out
  # NOTE: persist the lib_book object as well
  # TODO: Send email
  def update_hold_to_checkout(lib_book)
    book = Book.find(self[:book_id])

    if book.is_special?
      self.update({hold: nil, special_approval: true})
    else
      if self.update({hold: nil, start: Time.now, special_approval: false})
        lib_book.reduce_count
      end
    end
  end

  # update book count if checked out request is deleted
  def update_count_before_delete
    # increment book count if checked-out request type
    if self[:start] != nil && self[:end] == nil
      lib_book = Contain.get_lib_book(self[:library_id], self[:book_id])
      lib_book.increase_count
      lib_book.save
    end
  end
end
