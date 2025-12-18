# frozen_string_literal: true

# DO NOT load the main spec_helper for base configuration,
#   because it is always loaded first, by .rspec
# require_relative "../spec_helper"

# Load Capybara for browser-based tests
require "capybara/rspec"
require "capybara/dsl"

require_relative "support/shared_examples/integration"
require_relative "support/integration_helpers"

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Capybara::DSL, type: :feature

  # Tag all integration tests
  config.define_derived_metadata(file_path: %r{/spec/integration/}) do |metadata|
    metadata[:type] = :integration
    metadata[:integration] = true
  end

  # Configure Capybara
  Capybara.configure do |capybara_config|
    capybara_config.default_driver = :rack_test
    capybara_config.app_host = "http://example.org"
  end
end
