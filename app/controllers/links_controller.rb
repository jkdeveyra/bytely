class LinksController < ApplicationController
  serialization_scope :view_context

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
      flash[:error] = 'Oh snap! Link not found.'
      redirect_to root_path
    end
  end

  def clicks
    render json: Click.where(link_code: params[:id])
  end

  # GET /links/:id_or_code
  def show
    link = get_link
    if link
      render json: link
    else
      render json: nil, status: :not_found
    end
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
        format.json { render json: { link: result.link.errors }, status: :unprocessable_entity }
      end
    end
  end

  private
  def get_link
    if BSON::ObjectId.legal? params[:id]
      Link.find(params[:id])
    else
      Link.where(code: params[:id]).first
    end
  end
end
