class Book < ApplicationRecord
  has_many :contains
  has_many :libraries, through: :contains, dependent: :destroy
  has_one_attached :Image

  has_many :requests
  has_many :users, through: :requests, dependent: :destroy

  validates_uniqueness_of :isbn

  def self.get_book(book_id)
    Book.find_by(id: book_id)
  end

  def self.get_book_title(book_id)
    Book.select(:title).find_by(id: book_id)
  end

  # validates :Image, attached: true, content_type: ['image/png', 'image/jpeg']
end
