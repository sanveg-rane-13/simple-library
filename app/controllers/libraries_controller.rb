class LibrariesController < ApplicationController
  before_action :set_library, only: [:show, :edit, :update, :destroy, :lib_books]
  before_action :init_libraries, only: [:user_libs, :index]
  before_action :init_current_user, only: [:lib_books, :user_libs]

  # GET /libraries
  # GET /libraries.json
  def index
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
      if !current_user.student? && @library.save
        format.html { redirect_to @library, notice: "Library was successfully created." }
        format.json { render :show, status: :created, location: @library }
      elsif current_user.student?
        format.html { redirect_to "/", alert: "Students cannot add new libraries!" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
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
      if !current_user.student? && @library.update(library_params)
        format.html { redirect_to @library, notice: "Library was successfully updated." }
        format.json { render :show, status: :ok, location: @library }
      elsif current_user.student?
        format.html { redirect_to "/", alert: "Students cannot add edit libraries!" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      else
        format.html { render :edit }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1
  # DELETE /libraries/1.json
  # Deleting all requests made on books in the library and the associations with all librarians
  def destroy
    librarians = User.where(library_id: @library.id)

    respond_to do |format|
      if !current_user.student? && Request.where(library_id: @library.id).each { |r| r.destroy } && librarians.update(library_id: nil, library: nil) && @library.destroy
        format.html { redirect_to libraries_url, notice: "Library was successfully destroyed." }
        format.json { head :no_content }
      elsif !current_user.student?
        format.html { redirect_to "/", notice: "Students cannot delete libraries." }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to @library, alert: "Error deleting library" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET
  def user_libs
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
    @current_user = current_user
    @libraries = Library.get_lib_list_for_user(@current_user)
  end

  def init_current_user
    @current_user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def library_params
    params.require(:library).permit(:name, :university, :location, :max_borrow_days, :overdue_fine)
  end
end
