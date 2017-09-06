class SiteController < ApplicationController
  # Homepage
  def index
    @created_link = Link.find(params[:link_id]) if params[:link_id].present?
    @link = Link.new
  end
end
