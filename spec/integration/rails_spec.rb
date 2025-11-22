# frozen_string_literal: true

require_relative "spec_helper"
require "rack/test"

# Load Combustion and Rails
require_relative "../support/combustion_helper"

RSpec.describe "Rails Integration", :integration, integration_framework: :rails do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  before do
    # Set OmniAuth config for integration tests only
    OmniAuth.config.logger = OmniAuthIdentity::IntegrationLogger.for(:rails)
    OmniAuth.config.allowed_request_methods = %i[get post]
    OmniAuth.config.silence_get_warning = true

    OmniAuth.config.on_failure = ->(env) {
      OmniAuth::FailureEndpoint.new(env).call
    }

    OmniAuth::Strategies::Identity.option :on_failed_registration, lambda { |_env|
      Rack::Response.new(["Registration failed"], 422, {}).finish
    }

    # Clear database before each test
    User.delete_all
  end

  it_behaves_like "omniauth identity integration", "rails"

  describe "Rails-specific features" do
    it "loads Rails successfully" do
      expect(Rails.application).to be_a(Rails::Application)
      expect(Rails.env).to eq("test")
    end

    it "has ActiveRecord configured" do
      expect(ActiveRecord::Base.connection).to be_active
    end

    it "has User model with OmniAuth::Identity" do
      expect(User.ancestors).to include(OmniAuth::Identity::Models::ActiveRecord)
    end

    it "responds to root route" do
      get "/"
      expect(last_response).to be_ok
      expect(last_response.body).to eq("Rails Identity Test App")
    end

    it "creates users with ActiveRecord" do
      user = User.create!(
        name: "ActiveRecord Test",
        email: "ar@example.com",
        password: "test_password_123",
        password_confirmation: "test_password_123",
      )

      expect(user).to be_persisted
      expect(user.id).not_to be_nil
      expect(user.name).to eq("ActiveRecord Test")
      expect(user.email).to eq("ar@example.com")
    end

    it "locates users through ActiveRecord" do
      User.create!(
        name: "Locate Test",
        email: "locate@example.com",
        password: "test_password_123",
        password_confirmation: "test_password_123",
      )

      user = User.find_by(email: "locate@example.com")
      expect(user).not_to be_nil
      expect(user.name).to eq("Locate Test")
    end

    it "authenticates users with has_secure_password" do
      User.create!(
        name: "Auth Test",
        email: "auth@example.com",
        password: "test_password_123",
        password_confirmation: "test_password_123",
      )

      user = User.find_by(email: "auth@example.com")
      expect(user.authenticate("test_password_123")).to be_truthy
      expect(user.authenticate("wrong_password")).to be_falsey
    end

    it "enforces unique email with validation" do
      User.create!(
        name: "First User",
        email: "unique@example.com",
        password: "password123",
        password_confirmation: "password123",
      )

      expect {
        User.create!(
          name: "Second User",
          email: "unique@example.com",
          password: "password456",
          password_confirmation: "password456",
        )
      }.to raise_error(ActiveRecord::RecordInvalid, /Email has already been taken/)
    end

    it "validates required fields" do
      user = User.new(email: "test@example.com")
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "stores timestamps" do
      user = User.create!(
        name: "Timestamp Test",
        email: "timestamp@example.com",
        password: "test_password_123",
        password_confirmation: "test_password_123",
      )

      expect(user.created_at).to be_a(Time)
      expect(user.updated_at).to be_a(Time)
      expect(user.created_at).to be_within(1).of(Time.now)
    end
  end

  describe "Rails routing" do
    it "handles auth callback with JSON response" do
      User.create!(
        name: "Callback Test",
        email: "callback@example.com",
        password: "test_password_123",
        password_confirmation: "test_password_123",
      )

      post "/auth/identity/callback",
        {
          auth_key: "callback@example.com",
          password: "test_password_123",
        },
        {"HTTP_HOST" => "example.org", "rack.url_scheme" => "http"}

      follow_redirect! if last_response.redirect?

      if last_response.status == 200
        body = JSON.parse(last_response.body)
        expect(body["provider"]).to eq("identity")
        expect(body["uid"]).not_to be_nil
      end
    end
  end
end
