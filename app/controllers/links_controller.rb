class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /links
  def index
    @links = Link.all
  end

  # GET /:code
  def visit
    if params[:code]
      link = Link.where(code: params[:code]).first
      redirect_to link.url if link
      return
    end
    redirect_to :root_path
  end

  # GET /links/1
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  def create
    @link = Link.new(link_params)
    loop do
      code = RandomCode.generate
      unless Link.where(code: code).exists?
        @link.code = code
        break
      end
    end
    if @link.save
      redirect_to root_path(link_id: @link.id)
    else
      redirect_to root_path, notice: 'Unable to shorten link.'
    end
  end

  # PATCH/PUT /links/1
  def update
    if @link.update(link_params)
      redirect_to @link, notice: 'Link was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /links/1
  def destroy
    @link.destroy
    redirect_to links_url, notice: 'Link was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def link_params
    params.require(:link).permit(:title, :url, :code)
  end
end
