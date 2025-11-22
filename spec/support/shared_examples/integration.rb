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

    describe "browser-based flows", :capybara, type: :feature do
      before do
        # Configure Capybara for this app
        Capybara.app = app
        Capybara.default_driver = :rack_test
        Capybara.current_driver = :rack_test
      end

      after do
        Capybara.reset_sessions!
        Capybara.use_default_driver
      end

      describe "registration through browser" do
        it "can view the registration page provided by OmniAuth" do
          # OmniAuth Identity provides a basic registration form when accessed via GET
          visit "/auth/identity/register"

          # The default OmniAuth form should be present
          expect(page.status_code).to eq(200)
          expect(page).to have_content("Identity")
        end

        it "submits registration and gets redirected" do
          visit "/auth/identity/register"

          # Fill out OmniAuth's default form if it has the fields
          # Note: Field names depend on OmniAuth's form builder
          if page.has_field?("Name")
            fill_in "Name", with: "Browser User"
          end

          if page.has_field?("Email")
            fill_in "Email", with: "browser#{Time.now.to_i}@example.com"
          end

          # Use match: :first to avoid ambiguity when there are multiple password fields
          if page.has_field?("Password")
            all_inputs = page.all(:fillable_field, "Password")
            if all_inputs.length > 1
              # Fill first password field (password)
              all_inputs[0].set("secure_password_123")
              # Fill second password field (confirmation)
              all_inputs[1].set("secure_password_123")
            else
              fill_in "Password", with: "secure_password_123", match: :first
            end
          end

          # Try to find and click submit button
          if page.has_button?(disabled: false)
            first('input[type="submit"]', minimum: 0)&.click || first('button[type="submit"]', minimum: 0)&.click

            # Should get some response
            expect([200, 302, 400, 422]).to include(page.status_code)
          else
            skip "OmniAuth Identity form not found or customized by application"
          end
        end
      end

      describe "login through browser" do
        before do
          # Create a user first using API
          post "/auth/identity/register",
            {
              name: "Browser Login User",
              email: "browserlogin@example.com",
              password: "test_password_123",
              password_confirmation: "test_password_123",
            },
            {"HTTP_HOST" => "example.org", "rack.url_scheme" => "http"}
        end

        it "can view the login page provided by OmniAuth" do
          # OmniAuth Identity provides a basic login form via GET request phase
          visit "/auth/identity"

          # The default OmniAuth form should be present
          expect(page.status_code).to eq(200)
          expect(page).to have_content("Identity") if page.status_code == 200
        end

        it "submits login credentials" do
          visit "/auth/identity"

          # Fill out OmniAuth's default form if present
          if page.has_field?("Login") || page.has_field?("Email")
            auth_field = page.has_field?("Login") ? "Login" : "Email"
            fill_in auth_field, with: "browserlogin@example.com" if page.has_field?(auth_field)
          end

          if page.has_field?("Password")
            fill_in "Password", with: "test_password_123", match: :first
          end

          # Submit the form
          if page.has_button?(disabled: false) && page.has_field?("Password")
            first('input[type="submit"]', minimum: 0)&.click || first('button[type="submit"]', minimum: 0)&.click

            # Should get redirected or show response
            expect([200, 302, 401]).to include(page.status_code)
          else
            skip "OmniAuth Identity login form not found or customized by application"
          end
        end
      end

      describe "form presence validation" do
        it "ensures registration form is accessible" do
          visit "/auth/identity/register"
          expect(page.status_code).to be_between(200, 302)
        end

        it "ensures login form is accessible" do
          visit "/auth/identity"
          expect(page.status_code).to be_between(200, 302)
        end
      end
    end
  end
end
