# frozen_string_literal: true

# NOTE: mongoid and no_brainer can't be loaded at the same time.
#       If you try it, one or both of them will not work.
#       This is why the ORM specs are split into a separate directory and run in separate threads.

ENV['RUBY_ENV'] = 'test' # Used by NoBrainer
ENV['MONGOID_ENV'] = 'test' # Used by Mongoid

ruby_version = Gem::Version.new(RUBY_VERSION)
require 'simplecov' if ruby_version >= Gem::Version.new('2.7') && RUBY_ENGINE == 'ruby'

require 'rack/test'
require 'rspec/block_is_expected'
require 'byebug' if RUBY_ENGINE == 'ruby'

# This gem
require 'omniauth/identity'

spec_root_matcher = %r{#{__dir__}/(.+)\.rb\Z}
Dir.glob(Pathname.new(__dir__).join("support/**/", "*.rb")).each { |f| require f.match(spec_root_matcher)[1] }

DEFAULT_PASSWORD = 'hang-a-left-at-the-diner'
DEFAULT_EMAIL = 'mojo@example.com'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  # config.include ::Mongoid::Matchers, db: :mongodb

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
