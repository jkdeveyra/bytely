class Click
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :ip_address, type: String
  field :referer, type: String
  embedded_in :link
end
