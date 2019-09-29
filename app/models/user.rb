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
end
