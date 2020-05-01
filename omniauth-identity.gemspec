# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + '/lib/omniauth-identity/version'

Gem::Specification.new do |gem|
  gem.add_runtime_dependency 'omniauth'
  gem.add_runtime_dependency 'bcrypt'

  gem.add_development_dependency 'maruku'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 2.99'
  gem.add_development_dependency 'activerecord'
  gem.add_development_dependency 'mongoid'
  gem.add_development_dependency 'datamapper'
  gem.add_development_dependency 'bson_ext'
  gem.add_development_dependency 'byebug'
  gem.add_development_dependency 'couch_potato'

  gem.name = 'omniauth-identity'
  gem.version = OmniAuth::Identity::VERSION
  gem.description = %q{Internal authentication handlers for OmniAuth.}
  gem.summary = gem.description
  gem.email = ['michael@intridea.com']
  gem.homepage = 'http://github.com/intridea/omniauth-identity'
  gem.authors = ['Michael Bleigh']
  gem.license     = 'MIT'
  gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') if gem.respond_to? :required_rubygems_version=
end
