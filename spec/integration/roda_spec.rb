# frozen_string_literal: true

require_relative "spec_helper"
require "rack/test"

# Only run on Ruby 3.1+ (ROM 5.x requirement)
if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("3.1.0")
  require "roda"
  require "rom"
  require "rom-sql"

  require_relative "../dummies/roda_app/app"

  RSpec.describe "Roda Integration", :integration, integration_framework: :roda do
    include Rack::Test::Methods

    def app
      Rack::Builder.new do
        run Dummy::RodaApp
      end
    end

    before do
      # Set OmniAuth config for integration tests only
      OmniAuth.config.logger = OmniAuthIdentity::IntegrationLogger.for(:roda)
      OmniAuth.config.allowed_request_methods = %i[get post]
      OmniAuth.config.silence_get_warning = true

      OmniAuth.config.on_failure = ->(env) {
        OmniAuth::FailureEndpoint.new(env).call
      }

      OmniAuth::Strategies::Identity.option :on_failed_registration, lambda { |env|
        Rack::Response.new(["Registration failed"], 422, {}).finish
      }

      # Clear the identities table before each test
      RodaIdentity.delete_all
    end

    it_behaves_like "omniauth identity integration", "roda"

    describe "ROM-specific features" do
      it "uses ROM container and relations" do
        # Verify ROM container is properly configured
        expect(ROM_CONTAINER).to be_a(ROM::Container)
        expect(ROM_CONTAINER.relations[:roda_identities]).not_to be_nil
      end

      it "creates identities with ROM commands" do
        identity = RodaIdentity.create(
          name: "ROM Test",
          email: "rom@example.com",
          password: "test_password_123",
          password_confirmation: "test_password_123",
        )

        expect(identity).to be_a(RodaIdentity)
        expect(identity.name).to eq("ROM Test")
        expect(identity.email).to eq("rom@example.com")
        expect(identity.uid).not_to be_nil
      end

      it "locates identities through ROM adapter" do
        RodaIdentity.create(
          name: "Locate Test",
          email: "locate@example.com",
          password: "test_password_123",
          password_confirmation: "test_password_123",
        )

        identity = RodaIdentity.locate(email: "locate@example.com")
        expect(identity).to be_a(RodaIdentity)
        expect(identity.name).to eq("Locate Test")
        expect(identity.email).to eq("locate@example.com")
      end

      it "authenticates identities with BCrypt" do
        RodaIdentity.create(
          name: "Auth Test",
          email: "auth@example.com",
          password: "test_password_123",
          password_confirmation: "test_password_123",
        )

        identity = RodaIdentity.locate(email: "auth@example.com")
        expect(identity.authenticate("test_password_123")).to be_truthy
        expect(identity.authenticate("wrong_password")).to be_falsey
      end

      it "stores timestamps" do
        identity = RodaIdentity.create(
          name: "Timestamp Test",
          email: "timestamp@example.com",
          password: "test_password_123",
          password_confirmation: "test_password_123",
        )

        expect(identity[:created_at]).to be_a(Time)
        expect(identity[:updated_at]).to be_a(Time)
        expect(identity[:created_at]).to be_within(1).of(Time.now)
      end

      it "enforces unique email constraint" do
        RodaIdentity.create(
          name: "First User",
          email: "duplicate@example.com",
          password: "password123",
          password_confirmation: "password123",
        )

        duplicate = RodaIdentity.create(
          name: "Second User",
          email: "duplicate@example.com",
          password: "password456",
          password_confirmation: "password456",
        )

        expect(duplicate.persisted?).to be false
      end
    end

    describe "Roda routing" do
      it "handles root route" do
        get "/"
        expect(last_response).to be_ok
        expect(last_response.body).to eq("Roda Dummy App")
      end

      it "handles health check" do
        get "/health"
        expect(last_response).to be_ok
        expect(last_response.body).to eq("ok")
      end

      it "handles auth callback routes with JSON responses" do
        RodaIdentity.create(
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
else
  RSpec.describe "Roda Integration", :integration, integration_framework: :roda do
    it "skips tests on Ruby < 3.1" do
      skip "ROM requires Ruby 3.1+, current version: #{RUBY_VERSION}"
    end
  end
end

