class Book < ApplicationRecord
    has_many :libraries, through: :librarybook
end
