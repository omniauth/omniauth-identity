# frozen_string_literal: true

# NOTE: mongoid and no_brainer can't be loaded at the same time.
#       If you try it, one or both of them will not work.
#       This is why the ORM specs are split into a separate directory and run in separate threads.

ENV["RUBY_ENV"] = "test" # Used by NoBrainer
ENV["MONGOID_ENV"] = "test" # Used by Mongoid

# Bugfixes
# JRuby needed an explicit "require 'logger'" for Rails < 7.1
# See: https://github.com/rails/rails/issues/54260#issuecomment-2594650047
# Placing above omniauth because it is a dependency of omniauth,
#   which is undeclared in older versions.
require "logger"

# External RSpec & related config
require "kettle/test/rspec"

# External library dependencies
require "omniauth"
require "omniauth/version"

# RSpec Configs
require "config/debug"
require "config/omniauth"
require "config/rspec/rack_test"
require "config/vcr"

# RSpec Support
spec_root_matcher = %r{#{__dir__}/(.+)\.rb\Z}
Dir.glob(Pathname.new(__dir__).join("support/**/", "*.rb")).each { |f| require f.match(spec_root_matcher)[1] }

# In Ruby <= 2.4 we get this error when loading activerecord (probably due to some dependency):
# NoMethodError:
#   undefined method 'delete_prefix' for "CONTENT_LENGTH":String
# This is because delete_prefix was added in Ruby 2.5.
# So we add it here for older Rubies.
if VersionGem::Ruby::RUBY_VER < Gem::Version.new("2.5")
  require "backports/2.5.0/string/delete_prefix"
end

# Test Constants
DEFAULT_PASSWORD = "hang-a-left-at-the-diner"
DEFAULT_EMAIL = "mojo@example.com"

def omniauth_identity_env_truthy?(key)
  %w[true 1 yes on].include?(ENV.fetch(key, "false").downcase)
end

def omniauth_identity_bundled_gem?(*names)
  specs = if defined?(Bundler)
    Bundler.load.specs
  else
    Gem::Specification
  end

  names.any? do |name|
    begin
      if specs.respond_to?(:find_by_name)
        specs.find_by_name(name)
      else
        specs.any? { |spec| spec.name == name }
      end
    rescue Gem::LoadError
      false
    end
  end
end

def omniauth_identity_service_adapter_enabled?(adapter)
  omniauth_identity_env_truthy?("OMNIAUTH_IDENTITY_ENABLE_SERVICE_ADAPTERS") ||
    omniauth_identity_env_truthy?("OMNIAUTH_IDENTITY_ENABLE_#{adapter}")
end

def omniauth_identity_sqlite3_enabled?
  return true if omniauth_identity_env_truthy?("OMNIAUTH_IDENTITY_ENABLE_SQLITE3")

  if RUBY_ENGINE == "jruby"
    omniauth_identity_bundled_gem?("jdbc-sqlite3", "activerecord-jdbcsqlite3-adapter")
  else
    omniauth_identity_bundled_gem?("sqlite3")
  end
end

# The last thing before loading this gem is to set up code coverage
begin
  require "kettle-soup-cover"
  #   this next line has a side effect of running `.simplecov`
  require "simplecov" if defined?(Kettle::Soup::Cover) && Kettle::Soup::Cover::DO_COV
rescue LoadError => error
  # check the error message and conditionally re-raise
  raise error unless error.message.include?("kettle")
end

# This gem
require "omniauth-identity"
RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.filter_run_excluding(couchdb: true) unless omniauth_identity_service_adapter_enabled?("COUCHDB")
  config.filter_run_excluding(mongodb: true) unless omniauth_identity_service_adapter_enabled?("MONGODB")
  config.filter_run_excluding(rethinkdb: true) unless omniauth_identity_service_adapter_enabled?("RETHINKDB")
  config.filter_run_excluding(sqlite3: true) unless omniauth_identity_sqlite3_enabled?

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
