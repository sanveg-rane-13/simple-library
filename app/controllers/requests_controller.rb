class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :set_lib_book, only: [:check_out_book, :return_book, :hold_book, :rem_hold_book]

  # POST - Checkout request on book
  def check_out_book
    request = Request.new_checkout_obj(@lib_book, current_user.id)

    respond_to do |format|
      if (request.save && @lib_book.save)
        format.html { redirect_to show_lib_book_contain_path(@lib_book), notice: "Book checked out successfully!" }
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
    @request = Request.joins(:user, :book).select(:name, :title)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  def set_lib_book
    @lib_book = Contain.find(params[:lib_book_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.fetch(:request, {})
  end
end
