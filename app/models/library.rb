class Library < ApplicationRecord
  has_many :librarians

  has_many :contains
  has_many :books, through: :contains
end
