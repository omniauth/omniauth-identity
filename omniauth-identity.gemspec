# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + '/lib/omniauth-identity/version'

Gem::Specification.new do |gem|
  gem.add_runtime_dependency 'omniauth', '~> 1.2'
  gem.add_runtime_dependency 'bcrypt', '~> 3.1'

  gem.add_development_dependency 'maruku', '~> 0.7'
  gem.add_development_dependency 'simplecov', '~> 0.10'
  gem.add_development_dependency 'rack-test', '~> 0.6'
  gem.add_development_dependency 'rake', '~> 10.4'
  gem.add_development_dependency 'rspec', '~> 3.2'
  gem.add_development_dependency 'activerecord', '~> 4.2'
  gem.add_development_dependency 'mongoid', '~> 4.0'
  gem.add_development_dependency 'mongo_mapper', '~> 0.13'
  gem.add_development_dependency 'datamapper', '~> 1.2'
  gem.add_development_dependency 'bson_ext', '~> 1.12'
  gem.add_development_dependency 'couch_potato', '~> 1.4'

  gem.name = 'omniauth-identity'
  gem.version = OmniAuth::Identity::VERSION
  gem.description = %q{Internal authentication handlers for OmniAuth.}
  gem.summary = gem.description
  gem.email = ['michael@intridea.com']
  gem.homepage = 'http://github.com/intridea/omniauth-identity'
  gem.authors = ['Michael Bleigh']
  gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') if gem.respond_to? :required_rubygems_version=
end
