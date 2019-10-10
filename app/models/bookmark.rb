class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_uniqueness_of :book_id, :scope => [:user_id, :library_id]

  # create a new bookmark object
  def self.new_bookmark(lib_book, user_id)
    return Bookmark.new({ library_id: lib_book.library_id,
                         user_id: user_id,
                         book_id: lib_book.book_id })
  end

  # check if a book is bookmarked by a user
  def self.is_bookmarked(lib_book, user_id)
    bookmark = Bookmark.where({ library_id: lib_book.library_id,
                               user_id: user_id,
                               book_id: lib_book.book_id }).first
    return !bookmark.nil?
  end

  # fetch particular bookmark object
  def self.get_bookmark(lib_book, user_id)
    return Bookmark.where({ library_id: lib_book.library_id,
                           user_id: user_id,
                           book_id: lib_book.book_id }).first
  end

  # get all bookmarks of a user
  def self.get_all_bookmarks(user_id)
    return Bookmark.where(user_id: user_id)
  end

  # delete all bookmarks of particular lib book
  def self.delete_all_bookmarks(lib_book)
    Bookmark.where({ library_id: lib_book.library_id, book_id: lib_book.book_id }).destroy_all
  end

  def self.delete_all_user_bookmarks(user_id)
    Bookmark.where({ user_id: user_id }).destroy_all
  end

  def self.delete_all_book_bookmarks(book_id)
    Bookmark.where({ book_id: book_id }).destroy_all
  end
end
