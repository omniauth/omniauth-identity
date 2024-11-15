# frozen_string_literal: true

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
