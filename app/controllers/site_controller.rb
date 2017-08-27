class SiteController < ApplicationController
  def index
    @created_link = Link.find(params[:link_id]) if params[:link_id].present?
    @link = Link.new
  end

  def features
  end

  def about
  end
end
