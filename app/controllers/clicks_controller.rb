class ClicksController < ApplicationController
  before_action :set_click, only: [:show, :edit, :update, :destroy]

  # GET /clicks
  def index
    @clicks = Click.all
  end

  # GET /clicks/1
  def show
  end

  # GET /clicks/new
  def new
    @click = Click.new
  end

  # GET /clicks/1/edit
  def edit
  end

  # POST /clicks
  def create
    @click = Click.new(click_params)

    if @click.save
      redirect_to @click, notice: 'Click was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /clicks/1
  def update
    if @click.update(click_params)
      redirect_to @click, notice: 'Click was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /clicks/1
  # DELETE /clicks/1.json
  def destroy
    @click.destroy
    redirect_to clicks_url, notice: 'Click was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_click
      @click = Click.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def click_params
      params.require(:click).permit(:ip_address, :link_id, :referer)
    end
end
