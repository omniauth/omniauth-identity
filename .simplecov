# kettle-jem:freeze
# To retain chunks of comments & code during omniauth-identity templating:
# Wrap custom sections with freeze markers (e.g., as above and below this comment chunk).
# omniauth-identity will then preserve content between those markers across template runs.
# kettle-jem:unfreeze

require "kettle/soup/cover/config"

omniauth_identity_bundled_gem = lambda do |*names|
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

omniauth_identity_service_adapter_enabled = lambda do |adapter|
  enabled_values = %w[true 1 yes on]
  enabled_values.include?(ENV.fetch("OMNIAUTH_IDENTITY_ENABLE_SERVICE_ADAPTERS", "false").downcase) ||
    enabled_values.include?(ENV.fetch("OMNIAUTH_IDENTITY_ENABLE_#{adapter}", "false").downcase)
end

omniauth_identity_sqlite3_enabled = lambda do
  return true if %w[true 1 yes on].include?(ENV.fetch("OMNIAUTH_IDENTITY_ENABLE_SQLITE3", "false").downcase)

  if RUBY_ENGINE == "jruby"
    omniauth_identity_bundled_gem.call("jdbc-sqlite3", "activerecord-jdbcsqlite3-adapter")
  else
    omniauth_identity_bundled_gem.call("sqlite3")
  end
end

# Minimum coverage thresholds are set by kettle-soup-cover.
# They are controlled by ENV variables loaded by `mise` from `mise.toml`
# (with optional machine-local overrides in `.env.local`).
# If the values for minimum coverage need to change, they should be changed both there,
#   and in 2 places in .github/workflows/coverage.yml.
SimpleCov.start do
  track_files "lib/**/*.rb"
  track_files "lib/**/*.rake"
  track_files "exe/*.rb"

  add_filter "lib/omniauth/identity/models/couch_potato.rb" unless omniauth_identity_service_adapter_enabled.call("COUCHDB")
  add_filter "lib/omniauth/identity/models/mongoid.rb" unless omniauth_identity_service_adapter_enabled.call("MONGODB")
  add_filter "lib/omniauth/identity/models/nobrainer.rb" unless omniauth_identity_service_adapter_enabled.call("RETHINKDB")
  add_filter "lib/omniauth/identity/models/active_record.rb" unless omniauth_identity_sqlite3_enabled.call
  add_filter "lib/omniauth/identity/models/rom.rb" unless omniauth_identity_sqlite3_enabled.call
  add_filter "lib/omniauth/identity/models/sequel.rb" unless omniauth_identity_sqlite3_enabled.call
end
