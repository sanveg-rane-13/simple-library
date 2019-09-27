class Library < ApplicationRecord
    has_many :books, through: :librarybook
end
