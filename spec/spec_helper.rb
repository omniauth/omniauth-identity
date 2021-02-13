# frozen_string_literal: true

ruby_version = Gem::Version.new(RUBY_VERSION)
require 'simplecov' if ruby_version >= Gem::Version.new('2.7') && RUBY_ENGINE == 'ruby'

require 'rack/test'
require 'mongoid-rspec'
require 'sqlite3'
require 'anonymous_active_record'
require 'byebug' if RUBY_ENGINE == 'ruby'

# This gem
require 'omniauth/identity'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Mongoid::Matchers, type: :model

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

