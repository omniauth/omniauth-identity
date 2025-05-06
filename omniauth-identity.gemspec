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

  # Linux distros may package ruby gems differently,
  #   and securely certify them independently via alternate package management systems.
  # Ref: https://gitlab.com/pboling/rspec-stubbed_env/-/issues/3
  # Hence, only enable signing if `SKIP_GEM_SIGNING` is not set in ENV.
  # See CONTRIBUTING.md
  user_cert = "certs/#{ENV.fetch("GEM_CERT_USER", ENV["USER"])}.pem"
  cert_file_path = File.join(__dir__, user_cert)
  cert_chain = cert_file_path.split(",")
  cert_chain.select! { |fp| File.exist?(fp) }
  if cert_file_path && cert_chain.any?
    spec.cert_chain = cert_chain
    if $PROGRAM_NAME.end_with?("gem") && ARGV[0] == "build" && !ENV.include?("SKIP_GEM_SIGNING")
      spec.signing_key = File.join(Gem.user_home, ".ssh", "gem-private_key.pem")
    end
  end

  spec.summary = "Traditional username/password based authentication system for OmniAuth"
  spec.description = spec.summary
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
    "CONTRIBUTING.md",
    "LICENSE.txt",
    "README.md",
    "SECURITY.md",
  ]
  spec.bindir = "exe"
  spec.require_paths = ["lib"]

  spec.add_dependency("bcrypt", "~> 3.1")
  spec.add_dependency("mutex_m", "~> 0.3", ">= 0.3.0")
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
