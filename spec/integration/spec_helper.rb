# frozen_string_literal: true

# Load the main spec_helper for base configuration
require_relative "../spec_helper"

# Load Rack::Test for all integration tests
require "rack/test"

require_relative "../support/shared_examples/integration"

RSpec.configure do |config|
  config.include Rack::Test::Methods

  # Tag all integration tests
  config.define_derived_metadata(file_path: %r{/spec/integration/}) do |metadata|
    metadata[:type] = :integration
    metadata[:integration] = true
  end
end
