# Shared examples for OmniAuth integration tests
RSpec.shared_examples "omniauth identity integration" do |framework_name|
  include Rack::Test::Methods

  describe "#{framework_name} integration", integration_framework: framework_name.to_sym do
    describe "registration flow" do
      it "creates a new user with valid credentials", :check_output do
        post "/auth/identity/register",
          {
            name: "Test User",
            email: "test@example.com",
            password: "secure_password_123",
            password_confirmation: "secure_password_123",
          },
          {
            "HTTP_HOST" => "example.org",
            "HTTP_ORIGIN" => "http://example.org",
            "rack.url_scheme" => "http",
          }

        # $stderr.puts "=== REGISTRATION RESPONSE ==="
        # $stderr.puts "Status: #{last_response.status}"
        # $stderr.puts "Body: #{last_response.body}"
        # $stderr.puts "Request env HTTP_HOST: #{last_request.env["HTTP_HOST"]}"
        # $stderr.puts "Request env HTTP_ORIGIN: #{last_request.env["HTTP_ORIGIN"]}"
        # $stderr.puts "Request env SERVER_NAME: #{last_request.env["SERVER_NAME"]}"
        # $stderr.puts "============================"

        follow_redirect! if last_response.redirect?
        expect(last_response.status).to be_between(200, 302)
      end

      it "rejects registration with missing fields", :check_output do
        post "/auth/identity/register",
          {
            email: "test@example.com",
            # Missing password
          },
          {"HTTP_HOST" => "example.org", "rack.url_scheme" => "http"}

        follow_redirect! if last_response.redirect?
        expect(last_response.status).to be >= 400
      end

      it "rejects duplicate email registration", :check_output do
        post "/auth/identity/register",
          {
            name: "Test User",
            email: "duplicate@example.com",
            password: "secure_password_123",
            password_confirmation: "secure_password_123",
          },
          {"HTTP_HOST" => "example.org", "rack.url_scheme" => "http"}

        post "/auth/identity/register",
          {
            name: "Another User",
            email: "duplicate@example.com",
            password: "different_password",
            password_confirmation: "different_password",
          },
          {"HTTP_HOST" => "example.org", "rack.url_scheme" => "http"}

        follow_redirect! if last_response.redirect?
        expect(last_response.status).to be >= 400
      end
    end

    describe "login flow" do
      before do
        post "/auth/identity/register",
          {
            name: "Login Test",
            email: "login@example.com",
            password: "test_password_123",
            password_confirmation: "test_password_123",
          },
          {"HTTP_HOST" => "example.org", "rack.url_scheme" => "http"}
      end

      it "authenticates with valid credentials", :check_output do
        post "/auth/identity/callback",
          {
            auth_key: "login@example.com",
            password: "test_password_123",
          },
          {"HTTP_HOST" => "example.org", "rack.url_scheme" => "http"}

        # $stderr.puts "=== REGISTRATION RESPONSE ==="
        # $stderr.puts "Status: #{last_response.status}"
        # $stderr.puts "Body: #{last_response.body}"
        # $stderr.puts "Request env HTTP_HOST: #{last_request.env["HTTP_HOST"]}"
        # $stderr.puts "Request env HTTP_ORIGIN: #{last_request.env["HTTP_ORIGIN"]}"
        # $stderr.puts "Request env SERVER_NAME: #{last_request.env["SERVER_NAME"]}"
        # $stderr.puts "============================"

        follow_redirect! if last_response.redirect?
        expect(last_response.status).to be_between(200, 302)
      end

      it "rejects invalid password", :check_output do
        post "/auth/identity/callback",
          {
            auth_key: "login@example.com",
            password: "wrong_password",
          },
          {"HTTP_HOST" => "example.org", "rack.url_scheme" => "http"}

        follow_redirect!
        expect(last_response.status).to be >= 400
      end

      it "rejects non-existent user", :check_output do
        post "/auth/identity/callback",
          {
            auth_key: "nonexistent@example.com",
            password: "any_password",
          },
          {"HTTP_HOST" => "example.org", "rack.url_scheme" => "http"}

        follow_redirect!
        expect(last_response.status).to be >= 400
      end
    end
  end
end
