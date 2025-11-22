# frozen_string_literal: true

require "json"
require "sinatra/base"
require "omniauth"
require "omniauth/identity"

require_relative "models/identity"

module Dummy
  class App < Sinatra::Base

    # Use Rack::Session::Cookie instead of Sinatra's built-in sessions
    use Rack::Session::Cookie, secret: ENV.fetch(
      "SINATRA_SESSION_SECRET",
      "aRM1uGVWoh6Rx14Gc4XGmzhV8FehJNqZ2VjEe386BlZjv4hicoifs7804uPfWsxI",
    )
    configure :test, :development, :production do
      set :host_authorization, { permitted_hosts: [] }

      use OmniAuth::Builder do
        provider :identity,
          fields: %i[name email],
          locate_conditions: ->(req) { {email: req.params.fetch("auth_key", req.params["email"])} }
      end
    end

    helpers do
      def json_response(payload, status: 200)
        content_type :json
        halt status, JSON.generate(payload)
      end
    end

    get "/" do
      "Sinatra Dummy App"
    end

    get "/health" do
      "ok"
    end

    # OmniAuth callback success endpoint
    get "/auth/:provider/callback" do
      auth = request.env["omniauth.auth"]
      json_response({provider: params[:provider], uid: auth&.fetch("uid", nil)})
    end

    post "/auth/:provider/callback" do
      auth = request.env["omniauth.auth"]
      json_response({provider: params[:provider], uid: auth&.fetch("uid", nil)})
    end

    get "/auth/failure" do
      json_response({error: params[:message] || "failure"}, status: 401)
    end
  end
end

if ENV.fetch('DEBUG', 'false').casecmp('true').zero?
  puts "=== MIDDLEWARE START ==="
  Dummy::App.middleware.each do |middleware|
    puts middleware.inspect
  end
  puts "=== MIDDLEWARE END ==="
end
