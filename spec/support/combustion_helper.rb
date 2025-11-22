# frozen_string_literal: true

require "combustion"

# Initialize Combustion with minimal Rails components
Combustion.path = "spec/internal"

Combustion.initialize! :active_record, :action_controller do
  # Configure OmniAuth middleware
  config.middleware.use OmniAuth::Builder do
    provider :identity,
      fields: %i[name email],
      model: User,
      locate_conditions: ->(req) { {email: req.params.fetch("auth_key", req.params["email"])} }
  end

  # Session configuration
  config.session_store :cookie_store, key: "_rails_identity_test_session"
  config.secret_key_base = "9KHEBcgxHpoZhjQ3j8p2OKSS5oYBlMBDsO2khkc78LPPGErlr9HKrAhfwpP8l2UI"

  # Additional test configuration
  config.eager_load = false
  config.cache_classes = true
  config.consider_all_requests_local = true
  config.action_controller.allow_forgery_protection = false
  config.active_support.deprecation = :stderr
end

# Ensure database schema is loaded
# Combustion should handle this automatically, but we'll be explicit
if ActiveRecord::Base.connection.tables.empty?
  load File.expand_path("../internal/db/schema.rb", __dir__)
end
