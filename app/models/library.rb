class Library < ApplicationRecord
  has_many :librarians

  has_many :library_books
  has_many :books, through: :library_books

  has_many :requests
  has_many :users, through: :requests
end
