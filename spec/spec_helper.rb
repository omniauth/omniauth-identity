require 'rubygems'
require 'bundler'
Bundler.setup :default, :development, :test

# Third party gems to help with testing
require 'simplecov'
SimpleCov.start

require 'rack/test'
require 'mongoid-rspec'
require 'byebug'

# This gem
require 'omniauth/identity'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Mongoid::Matchers, type: :model
end

