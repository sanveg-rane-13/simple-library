class ContainsController < ApplicationController
  before_action :set_contain, only: [:show, :edit, :update, :destroy, :show_lib_book]

  # TODO: directly add book to library link from lib_books

  # GET /contains
  # GET /contains.json
  def index
    @current_user = current_user

    if params[:search].blank?
      @contains = Contain.joins(:book, :library).select(:title, :author, :name, :university, :subject, :isbn, :is_special, :summary, :edition, :published, :language)
    else
      @contains = Contain.joins(:book, :library).select(:title, :author, :name, :university, :subject, :isbn, :is_special, :summary, :edition, :published, :language)
        .where(["title LIKE ?", "%#{params[:title]}%"])
        .where(["author LIKE ?", "%#{params[:author]}%"])
        .where(["published LIKE ?", "%#{params[:published]}%"])
    end
  end

  # GET /contains/1
  # GET /contains/1.json
  def show
  end

  # GET /contains/new
  def new
    @contain = Contain.new
  end

  # GET /contains/1/edit
  def edit
  end

  # POST /contains
  # POST /contains.json
  def create
    @contain = Contain.new(contain_params)
    respond_to do |format|
      if @contain.save
        format.html { redirect_to new_contain_path, notice: "Success!" }
        format.json { render :show, status: :created, location: @contain }
      else
        format.html { render :new }
        format.json { render json: @contain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contains/1
  # PATCH/PUT /contains/1.json
  def update
    respond_to do |format|
      if @contain.update(contain_params)
        format.html { redirect_to lib_books_library_path(@contain.library_id), notice: "Book count updated!" }
        format.json { render :show, status: :ok, location: @contain }
      else
        format.html { render :edit }
        format.json { render json: @contain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contains/1
  # DELETE /contains/1.json
  def destroy
    lib_id = @contain.library_id
    @contain.destroy
    respond_to do |format|
      format.html { redirect_to lib_books_library_path(lib_id), notice: "Book was successfully removed from library." }
      format.json { head :no_content }
    end
  end

  # GET - Show details of book from a lib
  # Manages messages displayed on the book view
  def show_lib_book
    @library_accessed = Library.find(@contain.library_id)
    @book_accessed = Book.find(@contain.book_id)

    # check if book can be checked out or put on hold
    if (!current_user.is_max_allowed_reached)
      @show_checkout = Contain.can_checkout(@contain) && !Request.is_checked_out(@contain, current_user.id)
      @show_hold = Contain.can_hold(@contain) && !Request.is_checked_out(@contain, current_user.id) && !Request.is_on_hold(@contain, current_user.id)
    else
      @message = "You have reached the max limit to borrow books"
    end

    # if book checked out or put on hold
    @show_return = Request.is_checked_out(@contain, current_user.id)
    @show_cancel_hold = Request.is_on_hold(@contain, current_user.id)

    # book mark book
    # @bookmark = Request.is_bookmarked(@contain, current_user.id)

    # show return date if book is checked out
    if @show_return
      req = Request.get_request(@contain, current_user.id)
      @message = "Checkout Date: #{req.book_checkout_date}"
      @message.concat("<br>Return Date: #{req.book_return_date}")
      late_fine = req.get_late_fee
      if (late_fine > 0)
        @message.concat("<br>Fine: #{late_fine.to_s}")
      end
    end

    # show hold message if book on hold
    if @show_cancel_hold
      @message = "Book on hold. You will receive notification once available <br>"
      @message.concat("Hold count: #{Request.get_hold_count(@contain)}")
    end

    # show hold count if book not available
    if @show_hold
      @message = "Book unavailable <br>"
      @message.concat("Hold count: #{Request.get_hold_count(@contain)}")
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contain
    @contain = Contain.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contain_params
    # params.fetch(:contain, {})
    params.require(:contain).permit(:library_id, :book_id, :count)
  end
end
