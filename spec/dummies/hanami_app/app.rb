# frozen_string_literal: true

require "json"
require "rack"
require "omniauth"
require "omniauth/identity"

require_relative "models/hanami_identity"

module Dummy
  # Simple Rack-based app that mimics Hanami structure
  # Using plain Rack for simplicity since Hanami 2.x full setup is complex
  class HanamiApp
    def initialize
      @app = Rack::Builder.new do
        # Session middleware
        use Rack::Session::Cookie,
          secret: ENV.fetch("HANAMI_SESSION_SECRET", "test_secret_key_for_hanami_integration_testing_omniauth_identity_min_64_chars"),
          key: "hanami.session"

        # OmniAuth middleware
        use OmniAuth::Builder do
          provider :identity,
            fields: %i[name email],
            model: HanamiIdentity,
            locate_conditions: ->(req) { {email: req.params.fetch("auth_key", req.params["email"])} }
        end

        # Main app
        run ->(env) {
          request = Rack::Request.new(env)
          path = request.path_info
          method = request.request_method

          case [method, path]
          when ["GET", "/"]
            [200, {"Content-Type" => "text/plain"}, ["Hanami Dummy App"]]

          when ["GET", "/health"]
            [200, {"Content-Type" => "text/plain"}, ["ok"]]

          when ["GET", "/auth/identity/callback"], ["POST", "/auth/identity/callback"]
            # OmniAuth callback success
            auth = env["omniauth.auth"]
            [200, {"Content-Type" => "application/json"}, [JSON.generate({provider: "identity", uid: auth&.fetch("uid", nil)})]]

          when ["GET", "/auth/failure"]
            # OmniAuth failure
            [401, {"Content-Type" => "application/json"}, [JSON.generate({error: request.params[:message] || "failure"})]]

          else
            [404, {"Content-Type" => "text/plain"}, ["Not Found"]]
          end
        }
      end
    end

    def call(env)
      @app.call(env)
    end
  end
end

if ENV.fetch("DEBUG", "false").casecmp("true").zero?
  puts "=== HANAMI APP LOADED ==="
  puts "HanamiIdentity: #{HanamiIdentity}"
  puts "======================="
end
