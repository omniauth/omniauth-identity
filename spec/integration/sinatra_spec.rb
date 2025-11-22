# frozen_string_literal: true

require_relative "spec_helper"
require "rack/test"
require_relative "../dummies/sinatra_app/app"

RSpec.describe "Sinatra Integration", :integration, integration_framework: :sinatra do
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      run Dummy::App
    end
  end

  before do
    # Set OmniAuth config for integration tests only
    OmniAuth.config.logger = OmniAuthIdentity::IntegrationLogger.for(:sinatra)
    OmniAuth.config.allowed_request_methods = %i[get post]
    OmniAuth.config.silence_get_warning = true

    OmniAuth.config.on_failure = ->(env) {
      OmniAuth::FailureEndpoint.new(env).call
    }

    OmniAuth::Strategies::Identity.option :on_failed_registration, lambda { |env|
      Rack::Response.new(["Registration failed"], 422, {}).finish
    }
  end

  it_behaves_like "omniauth identity integration", "sinatra"
end
