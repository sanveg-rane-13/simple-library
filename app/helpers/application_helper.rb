module ApplicationHelper
  # methods to check type of user logged in
  def is_a_student_logged?
    user_signed_in? && current_user.student
  end

  def is_a_librarian_logged?
    user_signed_in? && current_user.librarian
  end

  def is_a_admin_logged?
    user_signed_in? && current_user.admin
  end
end
