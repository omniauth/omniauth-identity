# frozen_string_literal: true

# DO NOT load the main spec_helper for base configuration,
#   because it is always loaded first, by .rspec
# require_relative "../spec_helper"

# Load Rack::Test for all integration tests
require "rack/test"

require_relative "../support/shared_examples/integration"
require_relative "../support/integration_helpers"

RSpec.configure do |config|
  config.include Rack::Test::Methods

  # Tag all integration tests
  config.define_derived_metadata(file_path: %r{/spec/integration/}) do |metadata|
    metadata[:type] = :integration
    metadata[:integration] = true
  end
end
