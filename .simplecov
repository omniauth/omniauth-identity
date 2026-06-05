# kettle-jem:freeze
# To retain chunks of comments & code during omniauth-identity templating:
# Wrap custom sections with freeze markers (e.g., as above and below this comment chunk).
# omniauth-identity will then preserve content between those markers across template runs.
# kettle-jem:unfreeze

require "kettle/soup/cover/config"

omniauth_identity_service_adapter_enabled = lambda do |adapter|
  enabled_values = %w[true 1 yes on]
  enabled_values.include?(ENV.fetch("OMNIAUTH_IDENTITY_ENABLE_SERVICE_ADAPTERS", "false").downcase) ||
    enabled_values.include?(ENV.fetch("OMNIAUTH_IDENTITY_ENABLE_#{adapter}", "false").downcase)
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
end
