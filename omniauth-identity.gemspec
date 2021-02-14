# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-identity/version'

Gem::Specification.new do |gem|
  gem.add_runtime_dependency 'bcrypt'
  gem.add_runtime_dependency 'omniauth'

  gem.add_development_dependency 'anonymous_active_record', '>= 1.0.7'
  gem.add_development_dependency 'mongoid', '~> 7'
  gem.add_development_dependency 'nobrainer'
  gem.add_development_dependency 'rack-test', '~> 1'
  gem.add_development_dependency 'rake', '~> 13'
  gem.add_development_dependency 'rspec', '~> 3'
  gem.add_development_dependency 'sqlite3', '~> 1.4'
  # NOTE: Released version of couch_potato depends on activemodel ~> 4.0, so pull latest from github in Gemfile.
  # gem.add_development_dependency 'couch_potato', '~> 1.7'

  gem.required_ruby_version = '>= 2.4'
  gem.name = 'omniauth-identity'
  gem.version = OmniAuth::Identity::VERSION
  gem.description = 'Internal authentication handlers for OmniAuth.'
  gem.summary = gem.description
  gem.homepage = 'http://github.com/omniauth/omniauth-identity'
  gem.authors = ['Peter Boling', 'Andrew Roberts', 'Michael Bleigh']
  gem.license = 'MIT'
  gem.files = Dir['lib/**/*', 'LICENSE', 'README.md', 'CHANGELOG.md', 'CODE_OF_CONDUCT.md']
  gem.test_files = Dir['spec/**/*']
  gem.bindir        = 'exe'
  gem.rdoc_options  = ['--charset=UTF-8']
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') if gem.respond_to? :required_rubygems_version=
end
