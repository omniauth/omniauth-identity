# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-identity/version'

Gem::Specification.new do |spec|
  # See CONTRIBUTING.md
  spec.cert_chain = [ENV.fetch("GEM_CERT_PATH", "certs/#{ENV.fetch("GEM_CERT_USER", ENV["USER"])}.pem")]
  spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $PROGRAM_NAME.end_with?("gem")

  spec.name = "omniauth-identity"
  spec.version = OmniAuth::Identity::VERSION
  spec.authors = ["Peter Boling", "Andrew Roberts", "Michael Bleigh"]

  spec.summary = spec.description
  spec.description = "Traditional username/password based authentication system for OmniAuth"
  spec.homepage = "https://github.com/omniauth/#{spec.name}"

  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4"

  spec.files = Dir[
    # Splats (alphabetical)
    "lib/**/*",
    # Files (alphabetical)
    "CHANGELOG.md",
    "CODE_OF_CONDUCT.md",
    "LICENSE",
    "README.md",
  ]
  spec.bindir = "exe"
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'bcrypt'
  spec.add_runtime_dependency 'omniauth'

  ### Testing
  spec.add_development_dependency("rack-test", "~> 1")
  spec.add_development_dependency("rake", "~> 13")
  spec.add_development_dependency("rspec", "~> 3")
  spec.add_development_dependency("rspec-block_is_expected", "~> 1.0")

  ### ORMs
  spec.add_development_dependency("sqlite3", "~> 1.4")
  # NOTE: Released version of couch_potato depends on activemodel ~> 4.0, so pull latest from github in Gemfile.
  # gem.add_development_dependency 'couch_potato', '~> 1.7'
end
