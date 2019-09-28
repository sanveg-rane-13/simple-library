class Book < ApplicationRecord
  has_many :contains
  has_many :libraries, through: :contains
end
