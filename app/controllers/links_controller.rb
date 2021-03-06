class LinksController < ApplicationController
  serialization_scope :view_context

  # GET /:code
  def visit
    result = Link::Visit.run(params, request)
    if result.success?
      redirect_to result.url
    else
      flash[:error] = 'Oh snap! Link not found.'
      redirect_to root_path
    end
  end

  # GET /links/:code/clicks
  def clicks
    list = Click.where(link_code: params[:id])
      .limit(10)
      .skip(params[:after] || 0)
    render json: list
  end

  # GET /links/:id
  # GET /links/:code
  def show
    link = get_link
    if link
      render json: link
    else
      render json: nil, status: :not_found
    end
  end

  # GET /links/:code/stat
  def stat
    clicks = Link::Stat.run(params)
    render json: clicks
  end

  # POST /links
  def create
    result = Link::Create.run(params)
    respond_to do |format|
      if result.success?
        format.html { redirect_to root_path(link_id: result.link.id) }
        format.json { render json: result.link }
      else
        format.html { redirect_to root_path, notice: result.message }
        format.json { render json: { message: result.message }, status: :unprocessable_entity }
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
