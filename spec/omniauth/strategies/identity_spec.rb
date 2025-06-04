# frozen_string_literal: true

require "active_record"
require "anonymous_active_record"

RSpec.describe OmniAuth::Strategies::Identity, :sqlite3 do
  attr_accessor :app

  let(:env_hash) { last_response.headers["env"] }
  let(:auth_hash) { env_hash["omniauth.auth"] }
  let(:identity_hash) { env_hash["omniauth.identity"] }
  let(:identity_options) { {} }
  let(:app_options) { {} }
  let(:is_java) { RUBY_PLATFORM == "java" }
  let(:anon_ar) do
    AnonymousActiveRecord.generate(
      parent_klass: "OmniAuth::Identity::Models::ActiveRecord",
      columns: OmniAuth::Identity::Model::SCHEMA_ATTRIBUTES | %w[provider password_digest],
      connection_params: {adapter: is_java ? "jdbcsqlite3" : "sqlite3", encoding: "utf8", database: ":memory:"},
    ) do
      auth_key :email
      def balloon
        "🎈"
      end
    end
  end

  # the rack testing framework will call this method (to get app) as needed to run tests
  def app
    opts = identity_options.reverse_merge({model: anon_ar})
    script_name = app_options[:script_name]
    self.app = Rack::Builder.app do
      use Rack::Session::Cookie, secret: "1234567890qwertyuiop"
      if script_name
        map script_name do
          use OmniAuth::Strategies::Identity, opts
        end
      else
        use OmniAuth::Strategies::Identity, opts
      end
      run ->(env) { [404, {"env" => env}, ["HELLO!"]] }
    end
  end

  describe "path handling" do
    script_names = [nil]
    # The script name root of the path only works in Rails >= v7
    script_names << "/my_path" if defined?(ActiveRecord) && ActiveRecord.respond_to?(:gem_version) && (ActiveRecord.gem_version >= Gem::Version.new("7.0.0"))
    path_prefixes = ["/auth", "/my_auth", ""]
    provider_names = ["identity", "my_id"]
    script_names.product(path_prefixes, provider_names).each do |script_name, path_prefix, provider_name|
      ext_base_path = "#{script_name}#{path_prefix}/#{provider_name}"
      ext_callback_path = "#{ext_base_path}/callback"
      ext_register_path = "#{ext_base_path}/register"

      context "with base path '#{ext_base_path}'" do
        let(:app_options) { {script_name: script_name} }
        let(:identity_options) {
          {enable_registration: true, enable_login: true, path_prefix: path_prefix, name: provider_name}
        }

        it "calls app" do
          get "#{script_name}/hello/world"
          expect(last_response.body).to eq("HELLO!")
        end

        it "#request_phase displays form" do
          get ext_base_path
          expect(last_response.body).not_to eq("HELLO!")
          expect(last_response.body).to include("<form")
          expect(last_response.body).to include("action='#{ext_callback_path}'")
          expect(last_response.body).to include("href='#{ext_register_path}'")
        end

        it "#callback_phase is handled" do
          get ext_callback_path
          expect(last_response.body).not_to eq("HELLO!")
        end

        it "#registration_phase is handled" do
          get ext_register_path
          expect(last_response.body).not_to eq("HELLO!")
        end
      end
    end
  end

  describe "#request_phase" do
    context "with default settings" do
      let(:identity_options) { {model: anon_ar} }

      it "displays a form" do
        get "/auth/identity"

        expect(last_response.body).not_to eq("HELLO!")
        expect(last_response.body).to include("<form")
      end
    end

    context "when login is enabled" do
      context "when registration is enabled" do
        let(:identity_options) { {model: anon_ar, enable_registration: true, enable_login: true} }

        it "displays a form with a link to register" do
          get "/auth/identity"

          expect(last_response.body).not_to eq("HELLO!")
          expect(last_response.body).to include("<form")
          expect(last_response.body).to include("<a")
          expect(last_response.body).to include("Create an Identity")
        end
      end

      context "when registration is disabled" do
        let(:identity_options) { {model: anon_ar, enable_registration: false, enable_login: true} }

        it "displays a form without a link to register" do
          get "/auth/identity"

          expect(last_response.body).not_to eq("HELLO!")
          expect(last_response.body).to include("<form")
          expect(last_response.body).not_to include("<a")
          expect(last_response.body).not_to include("Create an Identity")
        end
      end
    end

    context "when login is disabled" do
      context "when registration is enabled" do
        let(:identity_options) { {model: anon_ar, enable_registration: true, enable_login: false} }

        if Gem::Version.create(OmniAuth::VERSION) >= Gem::Version.create("2.0.0")
          it "bypasses registration form" do
            get "/auth/identity"

            expect(last_response.body).to eq("HELLO!")
            expect(last_response.body).not_to include("<form")
            expect(last_response.body).not_to include("<a")
            expect(last_response.body).not_to include("Create an Identity")
          end
        else
          it "still has registration form" do
            get "/auth/identity"

            expect(last_response.body).to_not eq("HELLO!")
            expect(last_response.body).to include("<form")
            expect(last_response.body).to include("<a")
            # We still get a registration form for some reason in old active record
            expect(last_response.body).to include("Create an Identity")
          end
        end
      end

      context "when registration is disabled" do
        let(:identity_options) { {model: anon_ar, enable_registration: false, enable_login: false} }

        it "bypasses registration form" do
          get "/auth/identity"

          if Gem::Version.create(OmniAuth::VERSION) >= Gem::Version.create("2.0.0")
            expect(last_response.body).to eq("HELLO!")
            expect(last_response.body).not_to include("<form")
            expect(last_response.body).not_to include("<a")
            expect(last_response.body).not_to include("Create an Identity")
          else
            # We still get a login form for some reason in old active record
            expect(last_response.body).not_to include("Create an Identity")
          end
        end
      end
    end
  end

  describe "#callback_phase" do
    let(:user) { double(uid: "user1", info: {"name" => "Rockefeller"}) }

    context "with valid credentials" do
      before do
        allow(anon_ar).to receive("auth_key").and_return("email")
        expect(anon_ar).to receive("authenticate").with({"email" => "john"}, "awesome").and_return(user)
        post "/auth/identity/callback", auth_key: "john", password: "awesome"
      end

      it "populates the auth hash" do
        expect(auth_hash).to be_a(Hash)
      end

      it "populates the uid" do
        expect(auth_hash["uid"]).to eq("user1")
      end

      it "populates the info hash" do
        expect(auth_hash["info"]).to eq({"name" => "Rockefeller"})
      end
    end

    context "with invalid credentials" do
      before do
        allow(anon_ar).to receive("auth_key").and_return("email")
        OmniAuth.config.on_failure = ->(env) { [401, {}, [env["omniauth.error.type"].inspect]] }
        expect(anon_ar).to receive(:authenticate).with({"email" => "wrong"}, "login").and_return(false)
        post "/auth/identity/callback", auth_key: "wrong", password: "login"
      end

      it "fails with :invalid_credentials" do
        expect(last_response.body).to eq(":invalid_credentials")
      end
    end

    context "with auth scopes" do
      let(:identity_options) do
        {
          model: anon_ar,
          locate_conditions: lambda { |req|
            {model.auth_key => req.params["auth_key"], "user_type" => "admin"}
          },
        }
      end

      it "evaluates and pass through conditions proc" do
        allow(anon_ar).to receive("auth_key").and_return("email")
        expect(anon_ar).to receive("authenticate").with(
          {"email" => "john", "user_type" => "admin"},
          "awesome",
        ).and_return(user)
        post "/auth/identity/callback", auth_key: "john", password: "awesome"
      end
    end
  end

  describe "#registration_form" do
    context "registration is enabled" do
      it "triggers from /auth/identity/register by default" do
        get "/auth/identity/register"
        expect(last_response.body).to include("Register Identity")
      end
    end

    context "registration is disabled" do
      let(:identity_options) { {model: anon_ar, enable_registration: false} }

      it "calls app" do
        get "/auth/identity/register"
        expect(last_response.body).to include("HELLO!")
      end
    end

    it "supports methods other than GET and POST" do
      head "/auth/identity/register"
      expect(last_response.status).to eq(404)
    end
  end

  describe "#registration_phase" do
    context "registration is disabled" do
      let(:identity_options) { {model: anon_ar, enable_registration: false} }

      it "calls app" do
        post "/auth/identity/register"
        expect(last_response.body).to eq("HELLO!")
      end
    end

    context "with good identity" do
      let(:properties) do
        {
          name: "Awesome Dude",
          email: "awesome@example.com",
          password: "face",
          password_confirmation: "face",
          provider: "identity",
        }
      end

      it "sets the auth hash" do
        post "/auth/identity/register", properties
        expect(auth_hash["uid"]).to match(/\d+/)
        expect(auth_hash["provider"]).to eq("identity")
      end

      context "with on_validation proc" do
        let(:identity_options) do
          {model: anon_ar, on_validation: on_validation_proc}
        end
        let(:on_validation_proc) do
          lambda { |_env|
            false
          }
        end

        context "when validation fails" do
          it "does not set the env hash" do
            post "/auth/identity/register", properties
            expect(env_hash).to eq(nil)
          end

          it "renders registration form" do
            post "/auth/identity/register", properties
            expect(last_response.body).to include(described_class.default_options[:registration_form_title])
          end

          it "displays validation failure message" do
            post "/auth/identity/register", properties
            expect(last_response.body).to include(described_class.default_options[:validation_failure_message])
          end
        end

        context "when validation succeeds" do
          let(:on_validation_proc) do
            lambda { |_env|
              true
            }
          end

          it "sets the auth hash" do
            post "/auth/identity/register", properties
            expect(auth_hash["uid"]).to match(/\d+/)
            expect(auth_hash["provider"]).to eq("identity")
          end

          it "does not render registration form" do
            post "/auth/identity/register", properties
            expect(last_response.body).not_to include(described_class.default_options[:registration_form_title])
          end

          it "does not display validation failure message" do
            post "/auth/identity/register", properties
            expect(last_response.body).not_to include(described_class.default_options[:validation_failure_message])
          end

          it "does not display registration failure message" do
            post "/auth/identity/register", properties
            expect(last_response.body).not_to include(described_class.default_options[:registration_failure_message])
          end
        end
      end
    end

    context "with bad identity" do
      let(:properties) do
        {
          name: "Awesome Dude",
          email: "awesome@example.com",
          password: "NOT",
          password_confirmation: "MATCHING",
          provider: "identity",
        }
      end
      let(:invalid_identity) { double(persisted?: false, save: false) }

      before do
        expect(anon_ar).to receive(:new).with(properties).and_return(invalid_identity)
      end

      context "default" do
        it "shows registration form" do
          post "/auth/identity/register", properties
          expect(last_response.body).to include("Register Identity")
          expect(last_response.body).to include("One or more fields were invalid")
        end
      end

      context "custom on_failed_registration endpoint" do
        let(:identity_options) do
          {
            model: anon_ar,
            on_failed_registration: lambda { |env|
              [404, {"env" => env}, ["FAIL'DOH!"]]
            },
          }
        end

        it "sets the identity hash" do
          post "/auth/identity/register", properties
          expect(identity_hash).to eq(invalid_identity)
          expect(last_response.body).to include("FAIL'DOH!")
          expect(last_response.body).not_to include("One or more fields were invalid")
        end
      end

      context "with on_validation proc" do
        let(:identity_options) do
          {model: anon_ar, on_validation: on_validation_proc}
        end
        let(:on_validation_proc) do
          lambda { |_env|
            false
          }
        end

        context "when validation fails" do
          it "does not set the env hash" do
            post "/auth/identity/register", properties
            expect(env_hash).to eq(nil)
          end

          it "renders registration form" do
            post "/auth/identity/register", properties
            expect(last_response.body).to include(described_class.default_options[:registration_form_title])
          end

          it "displays validation failure message" do
            post "/auth/identity/register", properties
            expect(last_response.body).to include(described_class.default_options[:validation_failure_message])
          end
        end

        context "when validation succeeds" do
          let(:on_validation_proc) do
            lambda { |_env|
              true
            }
          end

          it "does not set the env hash" do
            post "/auth/identity/register", properties
            expect(env_hash).to eq(nil)
          end

          it "renders registration form" do
            post "/auth/identity/register", properties
            expect(last_response.body).to include(described_class.default_options[:registration_form_title])
          end

          it "does not display validation failure message" do
            post "/auth/identity/register", properties
            expect(last_response.body).not_to include(described_class.default_options[:validation_failure_message])
          end

          it "display registration failure message" do
            post "/auth/identity/register", properties
            expect(last_response.body).to include(described_class.default_options[:registration_failure_message])
          end
        end
      end
    end
  end
end
