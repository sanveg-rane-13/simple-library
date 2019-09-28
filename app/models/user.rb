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
end
