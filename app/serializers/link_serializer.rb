class LinkSerializer < ActiveModel::Serializer
  attribute :id
  attribute :title
  attribute :code
  attribute :shortened_url
  attribute :original_url

  def id
    object.id.to_s
  end

  def shortened_url
    view_context.link_shortened_path object
  end

  def original_url
    object.url
  end
end
