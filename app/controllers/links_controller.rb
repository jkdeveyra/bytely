class LinksController < ApplicationController
  serialization_scope :view_context

  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /links
  def index
    @links = Link.all
  end

  # GET /:code
  def visit
    result = Link::Visit.run(params, request)
    if result.success?
      redirect_to result.link.url
    else
      redirect_to root_path
    end
  end

  # GET /links/:id_or_code
  def show
    render json: @link
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
    result = Link::Create.run(params)
    respond_to do |format|
      if result.success?
        format.html { redirect_to root_path(link_id: result.link.id) }
        format.json { render json: result.link }
      else
        format.html { redirect_to root_path, notice: 'Unable to shorten link.' }
        format.json { render json: {event_item: result.link.errors}, status: :unprocessable_entity }
      end
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
    @link = if BSON::ObjectId.legal? params[:id]
      Link.find(params[:id])
    else
      Link.where(code: params[:id]).first
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def link_params
    params.require(:link).permit(:title, :url, :code)
  end
end
