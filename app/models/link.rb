class Link
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :url, type: String
  field :code, type: String

  validates :url, presence: true
  validates :code, presence: true

  has_many :clicks

  index({ url: 1, code: 1 })
end
