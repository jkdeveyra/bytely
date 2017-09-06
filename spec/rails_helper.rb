require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'support/database_cleaner'
require 'support/factory_girl'
require 'support/helpers/api_helpers'

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  # :request also includes the spec/api directory
  config.include ApiHelpers, type: :request
end
