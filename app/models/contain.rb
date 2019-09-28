class Contain < ApplicationRecord
  belongs_to :library
  belongs_to :book

  validates_uniqueness_of :book_id, :scope => :library_id
end
