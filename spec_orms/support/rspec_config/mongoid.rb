# frozen_string_literal: true

require "logger"
begin
  require "bson"
  require "bson/active_support"
rescue LoadError => error
  if RUBY_ENGINE == "jruby"
    warn("Failed to load bson for mongoid")
    warn("#{error.class}: #{error.message}")
  else
    raise error
  end
end
require "mongoid"
require "mongoid-rspec"

RSpec.configure do |config|
  config.include(Mongoid::Matchers, mongodb: true)
end

Mongoid.load!(File.join(__dir__, "mongoid.yml"))

class MongoidTestIdentity
  include ::Mongoid::Document
  include ::OmniAuth::Identity::Models::Mongoid
  store_in database: "db1", collection: "mongoid_test_identities"
  field :email, type: String
  field :password_digest, type: String
end
