class User < ApplicationRecord
  attr_readonly :email

  before_destroy :stop_destroy, prepend: true

  has_many :requests
  has_many :books, through: :requests

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Prevent deletion of admin
  def stop_destroy
    throw :abort if admin
  end

  # get pending approvals list
  def self.get_pending_approvals_list
    User.where({ pending_approval: true })
  end

  # get list of students
  def self.get_students
    User.where({ student: true })
  end

  # get list of librarians
  def self.get_librarians
    User.where({ librarian: true })
  end

  # get max allowed books as per education level
  def is_max_allowed_reached
    borrowed_books = Request.where({ user_id: self[:id], end: nil }).where.not(start: nil).count
    allowed = (self[:study_level] == "U") ? 2 : ((self[:study_level] == "M") ? 4 : ((self[:study_level] == "P") ? 6 : 2))
    borrowed_books >= allowed
  end
end
