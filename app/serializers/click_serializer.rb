class ClickSerializer < ActiveModel::Serializer
  attribute :id
  attribute :session_id
  attribute :ip_address
  attribute :referer
  attribute :browser
  attribute :version_major
  attribute :version_minor
  attribute :os_family
  attribute :os_version
  attribute :device_family
  attribute :device_brand
  attribute :device_model
  attribute :link_code
  attribute :created_at

  def id
    object.id.to_s
  end
end
