class Library < ApplicationRecord
  has_many :librarians

  has_many :contains
  has_many :books, through: :contains

  def self.get_lib_name(library_id)
    Library.select(:name).find_by(id: library_id).name
  end

  def self.get_by_lib_id(library_id)
    Library.where(id: library_id)
  end

  def self.get_lib_by_univ_name(univ_name)
    univ_name.nil? ? [] : Library.where(university: univ_name)
  end
end
