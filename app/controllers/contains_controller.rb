class ContainsController < ApplicationController
  before_action :set_contain, only: [:show, :edit, :update, :destroy]

  # GET /contains
  # GET /contains.json
  def index
    @current_user = current_user
    
    if params[:search].blank?
      @contains = Contain.joins(:book, :library).select(:title, :author, :name, :university, :subject, :isbn, :is_special, :summary, :edition, :published, :language)
    else
      @contains = Contain.joins(:book, :library).select(:title, :author, :name, :university, :subject, :isbn, :is_special, :summary, :edition, :published, :language)
                    .where(['title LIKE ?', "%#{params[:title]}%"])
                    .where(['author LIKE ?', "%#{params[:author]}%"])
                    .where(['published LIKE ?', "%#{params[:published]}%"])
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
        format.html { redirect_to @contain, notice: "Success!" }
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
        format.html { redirect_to @contain, notice: "Success!" }
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
    @contain.destroy
    respond_to do |format|
      format.html { redirect_to contains_url, notice: "Contain was successfully destroyed." }
      format.json { head :no_content }
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
