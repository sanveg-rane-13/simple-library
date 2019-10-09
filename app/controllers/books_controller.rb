class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @current_user = current_user
    @books = []
    if !@current_user.student?
      @books = Book.all
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    @book.Image.attach(params[:book][:Image])
    respond_to do |format|
      if !current_user.student? && @book.save
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      elsif current_user.student?
        format.html { redirect_to "/", alert: "Student cannot add new books!" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to @book, alert: "Error Creating book." }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    @book.Image.purge
    @book.Image.attach(params[:book][:Image])
    respond_to do |format|
      if !current_user.student? && @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      elsif current_user.student?
        format.html { redirect_to "/", alert: "Student cannot edit books!" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    respond_to do |format|
      if !current_user.student? && @book.destroy
        format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
        format.json { head :no_content }
      elsif current_user.student?
        format.html { redirect_to "/", alert: "Student cannot delete books!" }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Used to identify the library from which the book is requested
  def set_contains
    @contain = Contain.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:isbn, :title, :author, :subject, :is_special, :summary, :image_front_cover, :edition, :published, :language)
  end
end
