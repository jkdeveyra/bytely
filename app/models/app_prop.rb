# Represents the application wide property (key-value pair)
class AppProp
  include Mongoid::Document
  field :key, type: String
  field :value, type: String

  index({ key: 1 }, { unique: true })
end
