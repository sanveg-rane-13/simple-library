class ContainsController < ApplicationController
  before_action :set_contain, only: [:show, :edit, :update, :destroy]

  # TODO: directly add book to library link from lib_books

  # GET /contains
  # GET /contains.json
  def index
    @contains = Contain.all
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

  #GET
  def library_books
    lib_id = params[:library_id]
    lib_name = Library.get_lib_name(lib_id)
    lib_books = Contain.get_books_of_lib(lib_id)
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
