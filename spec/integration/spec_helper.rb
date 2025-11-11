# frozen_string_literal: true

# Load the main spec_helper for base configuration
require_relative "../spec_helper"

# Load Rack::Test for all integration tests
require "rack/test"

RSpec.configure do |config|
  config.include Rack::Test::Methods

  # Tag all integration tests
  config.define_derived_metadata(file_path: %r{/spec/integration/}) do |metadata|
    metadata[:type] = :integration
    metadata[:integration] = true
  end
end

# Shared examples for OmniAuth integration tests
RSpec.shared_examples "omniauth identity integration" do |framework_name|
  describe "#{framework_name} integration" do
    describe "registration flow" do
      it "creates a new user with valid credentials" do
        post "/auth/identity/register", {
          name: "Test User",
          email: "test@example.com",
          password: "secure_password_123",
          password_confirmation: "secure_password_123"
        }

        expect(last_response.status).to be_between(200, 302)
      end

      it "rejects registration with missing fields" do
        post "/auth/identity/register", {
          email: "test@example.com"
          # Missing password
        }

        expect(last_response.status).to be >= 400
      end

      it "rejects duplicate email registration" do
        # First registration
        post "/auth/identity/register", {
          name: "Test User",
          email: "duplicate@example.com",
          password: "secure_password_123",
          password_confirmation: "secure_password_123"
        }

        # Duplicate registration
        post "/auth/identity/register", {
          name: "Another User",
          email: "duplicate@example.com",
          password: "different_password",
          password_confirmation: "different_password"
        }

        expect(last_response.status).to be >= 400
      end
    end

    describe "login flow" do
      before do
        # Create a test user
        post "/auth/identity/register", {
          name: "Login Test",
          email: "login@example.com",
          password: "test_password_123",
          password_confirmation: "test_password_123"
        }
      end

      it "authenticates with valid credentials" do
        post "/auth/identity/callback", {
          auth_key: "login@example.com",
          password: "test_password_123"
        }

        expect(last_response.status).to be_between(200, 302)
      end

      it "rejects invalid password" do
        post "/auth/identity/callback", {
          auth_key: "login@example.com",
          password: "wrong_password"
        }

        expect(last_response.status).to be >= 400
      end

      it "rejects non-existent user" do
        post "/auth/identity/callback", {
          auth_key: "nonexistent@example.com",
          password: "any_password"
        }

        expect(last_response.status).to be >= 400
      end
    end

    describe "auth hash structure" do
      before do
        post "/auth/identity/register", {
          name: "Hash Test",
          email: "hash@example.com",
          password: "test_password_123",
          password_confirmation: "test_password_123"
        }
      end

      it "returns properly structured auth hash on success" do
        post "/auth/identity/callback", {
          auth_key: "hash@example.com",
          password: "test_password_123"
        }

        # Framework-specific: subclasses will verify auth hash structure
        # based on how the framework exposes the OmniAuth auth hash
      end
    end
  end
end

