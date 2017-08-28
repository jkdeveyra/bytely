class Click
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :session_id, type: String
  field :ip_address, type: String
  field :referer, type: String
  field :browser, type: String
  field :version_major, type: String
  field :version_minor, type: String
  field :os_family, type: String
  field :os_version, type: String
  field :device_family, type: String
  field :device_brand, type: String
  field :device_model, type: String

  belongs_to :link
end
