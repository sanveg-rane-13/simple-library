class RequestsController < ApplicationController
  before_action :set_request, only: [:approve_spl, :decline_spl]
  before_action :check_librarian, only: [:approve_spl, :decline_spl]
  before_action :set_lib_book, only: [:check_out_book, :return_book, :hold_book, :rem_hold_book]

  # POST - Checkout request on book
  def check_out_book
    request = Request.new_checkout_obj(@lib_book, current_user.id)
    success_msg = (request.special_approval) ? "Checkout request raised for book" : "Book checked out successfully!"

    respond_to do |format|
      if (request.save && @lib_book.save)
        format.html { redirect_to show_lib_book_contain_path(@lib_book), notice: success_msg }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { redirect_to show_lib_book_contain_path(@lib_book), alert: "Error checking out book" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST - Return a checked-out book
  # TODO: Check if any books on hold
  def return_book
    request = Request.get_return_request_obj(@lib_book, current_user.id)

    respond_to do |format|
      if request.update({ end: request.end }) && @lib_book.save
        format.html { redirect_to show_lib_book_contain_path(@lib_book), notice: "Book returned!" }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render show_lib_book_contain_path(@lib_book), alert: "Error returning book" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST - Put a book on hold
  def hold_book
    request = Request.new_hold_request_object(@lib_book, current_user.id)

    respond_to do |format|
      if request.save
        format.html { redirect_to show_lib_book_contain_path(@lib_book), notice: "Book set on hold!" }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render show_lib_book_contain_path(@lib_book), alert: "Error setting book on hold" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE - Delete a book hold request
  def rem_hold_book
    request = Request.new_cancel_hold_request_object(@lib_book, current_user.id)

    request.destroy
    respond_to do |format|
      format.html { redirect_to show_lib_book_contain_path(@lib_book), notice: "Book removed from hold" }
      format.json { head :no_content }
    end
  end

  #GET view held books
  def view_hold
    @current_user = current_user
    @hold_requests = Request.get_all_holds_for_lib(@current_user.library_id)
  end

  # GET get all requests made by the user
  def manage_req
    @user_book_reqs = Request.where({ user_id: current_user.id })
  end

  # GET all pending special approvals on the books in the library
  def spl_book_aprvl
    @pending_aprvl = Request.get_special_approvals_from_lib(current_user.library_id)
  end

  # POST approve pending special book approval request
  def approve_spl
    lib_book = Contain.get_lib_book(@request.library_id, @request.book_id)

    # if count is more that 0 then checkout the book for user, else delete the special approval request
    if lib_book.count > 0
      @request.start = Time.now
      @request.special_approval = false
      lib_book.count = lib_book.count - 1

      respond_to do |format|
        if @request.save && lib_book.save
          format.html { redirect_to spl_book_aprvl_path, notice: "Request approved!" }
          format.json { render :show, status: :created, location: @request }
        else
          format.html { render spl_book_aprvl_path, alert: "Error approving request" }
          format.json { render json: @request.errors, status: :unprocessable_entity }
        end
      end
    else
      @request.destroy
      respond_to do |format|
        format.html { redirect_to spl_book_aprvl_path, notice: "No book in library to checkout for user" }
        format.json { head :no_content }
      end
    end
  end

  # POST decline pending special book approval request
  def decline_spl
    @request.destroy
    respond_to do |format|
      format.html { redirect_to spl_book_aprvl_path, notice: "Request declined" }
      format.json { head :no_content }
    end
  end

  def view_borrow_history
    @current_user = current_user
    if current_user.admin?
      @requests = Request.all
    elsif current_user.librarian?
      @requests = Request.get_borrow_history_lib(current_user)
    end
  end

  def view_overdue_fine
    @current_user = current_user
    @objects = Request.get_student_overdue_fine(current_user)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  def set_lib_book
    @lib_book = Contain.find(params[:lib_book_id])
  end

  def check_librarian
    if !(current_user.librarian? || current_user.admin?)
      redirect_to root_path
    end
  end

  
  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.fetch(:request, {})
  end
end
