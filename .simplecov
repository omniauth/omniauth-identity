# kettle-jem:freeze
# To retain chunks of comments & code during omniauth-identity templating:
# Wrap custom sections with freeze markers (e.g., as above and below this comment chunk).
# omniauth-identity will then preserve content between those markers across template runs.
# kettle-jem:unfreeze

# Minimum coverage thresholds are set by kettle-soup-cover.
# They are controlled by ENV variables loaded by `mise` from `mise.toml`
# (with optional machine-local overrides in `.env.local`).
# If the values for minimum coverage need to change, they should be changed both there,
#   and in 2 places in .github/workflows/coverage.yml.
SimpleCov.configure do
  if SimpleCov::Configuration.method_defined?(:cover)
    cover "lib/**/*.rb", "lib/**/*.rake", "exe/*.rb"
  else
    track_files "{lib/**/*.rb,lib/**/*.rake,exe/*.rb}"
  end
  cover "lib/**/*.rb", "lib/**/*.rake", "exe/*.rb"

  bundled_gem = lambda do |*names|
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

  env_truthy = lambda do |key|
    %w[true 1 yes on].include?(ENV.fetch(key, "false").downcase)
  end

  service_adapter_enabled = lambda do |adapter|
    env_truthy.call("OMNIAUTH_IDENTITY_ENABLE_SERVICE_ADAPTERS") ||
      env_truthy.call("OMNIAUTH_IDENTITY_ENABLE_#{adapter}")
  end

  sqlite3_enabled = lambda do
    next true if env_truthy.call("OMNIAUTH_IDENTITY_ENABLE_SQLITE3")

    if RUBY_ENGINE == "jruby"
      bundled_gem.call("jdbc-sqlite3", "activerecord-jdbcsqlite3-adapter")
    else
      bundled_gem.call("sqlite3")
    end
  end

  skip "lib/omniauth/identity/models/couch_potato.rb" unless service_adapter_enabled.call("COUCHDB")
  skip "lib/omniauth/identity/models/mongoid.rb" unless service_adapter_enabled.call("MONGODB")
  skip "lib/omniauth/identity/models/nobrainer.rb" unless service_adapter_enabled.call("RETHINKDB")
  unless sqlite3_enabled.call
    skip "lib/omniauth/identity/models/active_record.rb"
    skip "lib/omniauth/identity/models/rom.rb"
    skip "lib/omniauth/identity/models/sequel.rb"
    skip "lib/omniauth/strategies/identity.rb"
  end
end
