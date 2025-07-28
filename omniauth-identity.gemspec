# frozen_string_literal: true

gem_version =
  if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("3.1")
    # Loading Version into an anonymous module allows version.rb to get code coverage from SimpleCov!
    # See: https://github.com/simplecov-ruby/simplecov/issues/557#issuecomment-2630782358
    Module.new.tap { |mod| Kernel.load("lib/omniauth/identity/version.rb", mod) }::OmniAuth::Identity::Version::VERSION
  else
    require_relative "lib/omniauth/identity/version"
    OmniAuth::Identity::Version::VERSION
  end

Gem::Specification.new do |spec|
  spec.name = "omniauth-identity"
  spec.version = gem_version
  spec.authors = ["Peter Boling", "Andrew Roberts", "Michael Bleigh"]
  spec.email = ["floss@galtzo.com"]

  # Linux distros often package gems and securely certify them independent
  #   of the official RubyGem certification process. Allowed via ENV["SKIP_GEM_SIGNING"]
  # Ref: https://gitlab.com/oauth-xx/version_gem/-/issues/3
  # Hence, only enable signing if `SKIP_GEM_SIGNING` is not set in ENV.
  # See CONTRIBUTING.md
  unless ENV.include?("SKIP_GEM_SIGNING")
    user_cert = "certs/#{ENV.fetch("GEM_CERT_USER", ENV["USER"])}.pem"
    cert_file_path = File.join(__dir__, user_cert)
    cert_chain = cert_file_path.split(",")
    cert_chain.select! { |fp| File.exist?(fp) }
    if cert_file_path && cert_chain.any?
      spec.cert_chain = cert_chain
      if $PROGRAM_NAME.end_with?("gem") && ARGV[0] == "build"
        spec.signing_key = File.join(Gem.user_home, ".ssh", "gem-private_key.pem")
      end
    end
  end

  spec.summary = "Traditional username/password based authentication system for OmniAuth"
  spec.description = spec.summary
  spec.homepage = "https://github.com/omniauth/#{spec.name}"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4"

  spec.metadata["homepage_uri"] = "https://#{spec.name}.galtzo.com/"
  spec.metadata["source_code_uri"] = "#{spec.homepage}/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["wiki_uri"] = "#{spec.homepage}/wiki"
  spec.metadata["funding_uri"] = "https://github.com/sponsors/pboling"
  spec.metadata["news_uri"] = "https://www.railsbling.com/tags/#{spec.name}"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir[
    # Splats (alphabetical)
    "lib/**/*.rb",
  ]
  # Automatically included with gem package, no need to list again in files.
  spec.extra_rdoc_files = Dir[
    # Files (alphabetical)
    "CHANGELOG.md",
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "LICENSE.txt",
    "README.md",
    "SECURITY.md",
  ]
  spec.rdoc_options += [
    "--title",
    "#{spec.name} - #{spec.summary}",
    "--main",
    "CHANGELOG.md",
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "LICENSE.txt",
    "README.md",
    "SECURITY.md",
    "--line-numbers",
    "--inline-source",
    "--quiet",
  ]
  spec.require_paths = ["lib"]
  spec.bindir = "exe"
  spec.executables = []

  spec.add_dependency("bcrypt", "~> 3.1")                 # ruby >= 0
  spec.add_dependency("mutex_m", "~> 0.1")                # ruby >= 0
  spec.add_dependency("omniauth", ">= 1")                 # ruby >= 0
  spec.add_dependency("version_gem", ">= 1.1.8", "< 3")   # ruby >= 2.2

  ### Testing
  spec.add_development_dependency("activerecord", ">= 5")                           # ruby >= 2.2.2
  spec.add_development_dependency("anonymous_active_record", "~> 1.0", ">= 1.0.9")  # ruby >= 2.4
  spec.add_development_dependency("appraisal2", "~> 3.0")                           # ruby >= 1.8.7
  spec.add_development_dependency("rack-test", "~> 1")                              # ruby >= 2.0
  spec.add_development_dependency("rake", "~> 13.0")                                # ruby >= 2.2
  spec.add_development_dependency("rspec", "~> 3.13")                               # ruby >= 0
  spec.add_development_dependency("rspec-block_is_expected", "~> 1.0", ">= 1.0.6")  # ruby >= 1.8.7

  ### Releasing
  spec.add_development_dependency("stone_checksums", "~> 1.0")                      # ruby >= 2.2
end
