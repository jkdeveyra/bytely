class LinkSerializer < ActiveModel::Serializer
  attribute :id
  attribute :title
  attribute :code
  attribute :shorten_url
  attribute :original_url

  def id
    object.id.to_s
  end

  def shorten_url
    view_context.link_shorten_path object
  end

  def original_url
    object.url
  end
end
