# frozen_string_literal: true

require "json"
require "roda"
require "omniauth"
require "omniauth/identity"

require_relative "models/roda_identity"

module Dummy
  class RodaApp < Roda
    # Use Rack::Session::Cookie for OmniAuth compatibility
    use Rack::Session::Cookie,
      secret: ENV.fetch("RODA_SESSION_SECRET", "test_secret_key_for_roda_integration_testing_omniauth_identity_min_64_chars"),
      key: "roda.session"

    # OmniAuth middleware
    use OmniAuth::Builder do
      provider :identity,
        fields: %i[name email],
        model: RodaIdentity,
        locate_conditions: ->(req) { {email: req.params.fetch("auth_key", req.params["email"])} }
    end

    route do |r|
      # Root endpoint
      r.root do
        "Roda Dummy App"
      end

      # Health check
      r.get "health" do
        "ok"
      end

      # Auth routes
      r.on "auth" do
        # OmniAuth callback success endpoint
        r.on String do |provider|
          r.get "callback" do
            auth = request.env["omniauth.auth"]
            response["Content-Type"] = "application/json"
            JSON.generate({provider: provider, uid: auth&.fetch("uid", nil)})
          end

          r.post "callback" do
            auth = request.env["omniauth.auth"]
            response["Content-Type"] = "application/json"
            JSON.generate({provider: provider, uid: auth&.fetch("uid", nil)})
          end
        end

        # OmniAuth failure endpoint
        r.get "failure" do
          response.status = 401
          response["Content-Type"] = "application/json"
          JSON.generate({error: request.params[:message] || "failure"})
        end
      end
    end
  end
end

if ENV.fetch("DEBUG", "false").casecmp("true").zero?
  puts "=== RODA APP LOADED ==="
  puts "Middleware: #{Dummy::RodaApp.opts[:middleware]&.inspect}"
  puts "======================="
end

