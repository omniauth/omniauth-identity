# frozen_string_literal: true

# Get the GEMFILE_VERSION without *require* "my_gem/version", for code coverage accuracy
# See: https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-825171399
load "lib/omniauth/identity/version.rb"
gem_version = OmniAuth::Identity::Version::VERSION
OmniAuth::Identity::Version.send(:remove_const, :VERSION)

Gem::Specification.new do |spec|
  spec.name = "omniauth-identity"
  spec.version = gem_version
  spec.authors = ["Peter Boling", "Andrew Roberts", "Michael Bleigh"]
  spec.email = ["peter.boling@gmail.com"]

  # See CONTRIBUTING.md
  spec.cert_chain = [ENV.fetch("GEM_CERT_PATH", "certs/#{ENV.fetch("GEM_CERT_USER", ENV["USER"])}.pem")]
  spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $PROGRAM_NAME.end_with?("gem")

  spec.summary = spec.description
  spec.description = "Traditional username/password based authentication system for OmniAuth"
  spec.homepage = "https://github.com/omniauth/#{spec.name}"

  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4"

  spec.metadata["homepage_uri"] = "https://railsbling.com/tags/#{spec.name}/"
  spec.metadata["source_code_uri"] = "#{spec.homepage}/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["wiki_uri"] = "#{spec.homepage}/wiki"
  spec.metadata["funding_uri"] = "https://liberapay.com/pboling"
  spec.metadata["rubygems_mfa_required"] = "true"

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

  spec.add_dependency("bcrypt", "~> 3.1")
  spec.add_dependency("omniauth", ">= 1")
  spec.add_dependency("version_gem", "~> 1.1", ">= 1.1.4")

  ### Testing
  spec.add_development_dependency("activerecord", ">= 5")
  spec.add_development_dependency("anonymous_active_record", "~> 1.0", ">= 1.0.9")
  spec.add_development_dependency("appraisal", "~> 2.5")
  spec.add_development_dependency("rack-test", "~> 1")
  spec.add_development_dependency("rake", "~> 13")
  spec.add_development_dependency("rspec", "~> 3")
  spec.add_development_dependency("rspec-block_is_expected", "~> 1.0", ">= 1.0.6")

  ### ORMs
  spec.add_development_dependency("sqlite3", ">= 1")
end
