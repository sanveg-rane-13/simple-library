class Request < ApplicationRecord
  belongs_to :student
  belongs_to :book

  validates_uniqueness_of :book_id, :scope => :student_id
end
