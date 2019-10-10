class Book < ApplicationRecord
  before_destroy :on_destroy

  has_many :contains
  has_many :libraries, through: :contains, dependent: :destroy

  has_one_attached :Image

  has_many :bookmarks
  has_many :users, through: :bookmarks, dependent: :destroy

  has_many :requests
  has_many :users, through: :requests, dependent: :destroy

  validates_uniqueness_of :isbn

  def self.get_book(book_id)
    Book.find_by(id: book_id)
  end

  def self.get_book_title(book_id)
    Book.select(:title).find_by(id: book_id)
  end

  def on_destroy
    # delete all bookmarks on the book
    Bookmark.delete_all_book_bookmarks(self[:id])
  end
end
