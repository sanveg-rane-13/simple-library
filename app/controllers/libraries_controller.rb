class LibrariesController < ApplicationController
  before_action :set_library, only: [:show, :edit, :update, :destroy, :lib_books]
  before_action :init_libraries, only: [:user_libs]
  before_action :init_current_user, only: [:lib_books, :user_libs]

  # GET /libraries
  # GET /libraries.json
  def index
    @libraries = Library.all
    @current_user = current_user
  end

  # GET /libraries/1
  # GET /libraries/1.json
  def show
  end

  # GET /libraries/new
  def new
    @library = Library.new
  end

  # GET /libraries/1/edit
  def edit
  end

  # POST /libraries
  # POST /libraries.json
  def create
    @library = Library.new(library_params)

    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: "Library was successfully created." }
        format.json { render :show, status: :created, location: @library }
      else
        format.html { render :new }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /libraries/1
  # PATCH/PUT /libraries/1.json
  def update
    respond_to do |format|
      if @library.update(library_params)
        format.html { redirect_to @library, notice: "Library was successfully updated." }
        format.json { render :show, status: :ok, location: @library }
      else
        format.html { render :edit }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1
  # DELETE /libraries/1.json
  def destroy
    @library.destroy
    respond_to do |format|
      format.html { redirect_to libraries_url, notice: "Library was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET
  def user_libs
    if (@current_user.student)
      @libraries = Library.get_lib_by_univ_name(@current_user.university)
    elsif (@current_user.librarian)
      @libraries = Library.get_by_lib_id(@current_user.library_id)
    elsif (@current_user.admin)
      @libraries = Library.all
    end
  end

  # GET - books in a library
  def lib_books
    @contains_books = Contain.get_books_of_lib(@library.id)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_library
    @library = Library.find(params[:id])
  end

  # Empty list of libraries before fetching
  def init_libraries
    @libraries = []
  end

  def init_current_user
    @current_user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def library_params
    params.require(:library).permit(:name, :university, :location, :max_borrow_days, :overdue_fine)
  end
end
