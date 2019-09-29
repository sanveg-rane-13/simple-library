class Book < ApplicationRecord
  has_many :contains
  has_many :libraries, through: :contains

  has_many :requests
  has_many :users, through: :requests
end
