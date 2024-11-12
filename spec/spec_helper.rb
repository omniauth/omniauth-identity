# frozen_string_literal: true

# NOTE: mongoid and no_brainer can't be loaded at the same time.
#       If you try it, one or both of them will not work.
#       This is why the ORM specs are split into a separate directory and run in separate threads.

ENV["RUBY_ENV"] = "test" # Used by NoBrainer
ENV["MONGOID_ENV"] = "test" # Used by Mongoid

# External library dependencies
require "version_gem/ruby"

# RSpec Configs
require "config/byebug"
require "config/rspec/rack_test"
require "config/rspec/rspec_block_is_expected"
require "config/rspec/rspec_core"
require "config/rspec/version_gem"

# RSpec Support
spec_root_matcher = %r{#{__dir__}/(.+)\.rb\Z}
Dir.glob(Pathname.new(__dir__).join("support/**/", "*.rb")).each { |f| require f.match(spec_root_matcher)[1] }

# Test Constants
DEFAULT_PASSWORD = "hang-a-left-at-the-diner"
DEFAULT_EMAIL = "mojo@example.com"

# Last thing before loading this gem is to setup code coverage
begin
  # This does not require "simplecov", but
  require "kettle-soup-cover"
  #   this next line has a side-effect of running `.simplecov`
  require "simplecov" if defined?(Kettle::Soup::Cover) && Kettle::Soup::Cover::DO_COV
rescue LoadError
  nil
end

# This gem
require "omniauth-identity"
