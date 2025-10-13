# frozen_string_literal: true

module OmniAuth
  module Strategies
    # The identity strategy allows you to provide simple internal
    # user authentication using the same process flow that you
    # use for external OmniAuth providers.
    #
    # @example Basic Setup
    #   use OmniAuth::Strategies::Identity,
    #       fields: [:email],
    #       model: User
    #
    # @example With Registration
    #   use OmniAuth::Strategies::Identity,
    #       fields: [:email, :name],
    #       model: User,
    #       enable_registration: true
    #
    # @see https://github.com/omniauth/omniauth-identity
    class Identity
      # @!attribute [r] DEFAULT_REGISTRATION_FIELDS
      # Default fields required for registration.
      # @return [Array<Symbol>]
      DEFAULT_REGISTRATION_FIELDS = %i[password password_confirmation].freeze
      include OmniAuth::Strategy

      # @!attribute [rw] fields
      # The fields to collect for user registration.
      # @return [Array<Symbol>]
      option :fields, %i[name email]

      # @!attribute [rw] enable_registration
      # Whether to enable user registration functionality.
      # @return [true, false]
      option :enable_registration, true   # See #other_phase and #request_phase

      # @!attribute [rw] enable_login
      # Whether to enable login functionality.
      # @return [true, false]
      option :enable_login, true          # See #other_phase

      # @!attribute [rw] on_login
      # Custom login handler. If provided, called instead of showing the default login form.
      # @return [Proc, nil]
      option :on_login, nil               # See #request_phase

      # @!attribute [rw] on_validation
      # Custom validation handler for registration.
      # @return [Proc, nil]
      option :on_validation, nil          # See #registration_phase

      # @!attribute [rw] on_registration
      # Custom registration handler. If provided, called instead of showing the default registration form.
      # @return [Proc, nil]
      option :on_registration, nil        # See #registration_phase

      # @!attribute [rw] on_failed_registration
      # Custom handler for failed registration.
      # @return [Proc, nil]
      option :on_failed_registration, nil # See #registration_phase

      # @!attribute [rw] locate_conditions
      # Conditions for locating an identity during login.
      # @return [Proc, Hash]
      option :locate_conditions, ->(req) { {model.auth_key => req.params["auth_key"]} }

      # @!attribute [rw] create_identity_link_text
      # Text for the link to create a new identity.
      # @return [String]
      option :create_identity_link_text, "Create an Identity"

      # @!attribute [rw] registration_failure_message
      # Message to display on registration failure.
      # @return [String]
      option :registration_failure_message, "One or more fields were invalid"

      # @!attribute [rw] validation_failure_message
      # Message to display on validation failure.
      # @return [String]
      option :validation_failure_message, "Validation failed"

      # @!attribute [rw] title
      # Title for the login form.
      # @return [String]
      option :title, "Identity Verification" # Title for Login Form

      # @!attribute [rw] registration_form_title
      # Title for the registration form.
      # @return [String]
      option :registration_form_title, "Register Identity" # Title for Registration Form

      # Handles the initial request phase.
      #
      # Shows the login form or calls the custom on_login handler.
      #
      # @return [Rack::Response] the response to send
      def request_phase
        if options[:on_login]
          options[:on_login].call(env)
        else
          build_omniauth_login_form.to_response
        end
      end

      # Handles the callback phase after login.
      #
      # Authenticates the user and calls super if successful.
      #
      # @return [void]
      def callback_phase
        return fail!(:invalid_credentials) unless identity

        super
      end

      # Handles other phases like registration.
      #
      # Routes to registration or login based on the path and options.
      #
      # @return [void]
      def other_phase
        if options[:enable_registration] && on_registration_path?
          if request.get?
            registration_form
          elsif request.post?
            registration_phase
          else
            call_app!
          end
        elsif options[:enable_login] && on_request_path?
          # OmniAuth, by default, disables "GET" requests for security reasons.
          # This effectively disables omniauth-identity tool's login form feature.
          # Because it is disabled by default, and because enabling it globally would affect the security of all
          #   other OmniAuth strategies that are present, we do not ask users to modify that setting.
          # Instead, we use this hook in the "other_phase", with a config setting of our own: `enable_login`
          request_phase
        else
          call_app!
        end
      end

      # Shows the registration form or calls the custom on_registration handler.
      #
      # @param validation_message [String, nil] message to display if validation failed
      # @return [Rack::Response] the response to send
      def registration_form(validation_message = nil)
        if options[:on_registration]
          options[:on_registration].call(env)
        else
          build_omniauth_registration_form(validation_message).to_response
        end
      end

      # Handles the registration phase.
      #
      # Creates a new identity and saves it.
      #
      # @return [void]
      def registration_phase
        attributes = (options[:fields] + DEFAULT_REGISTRATION_FIELDS).each_with_object({}) do |k, h|
          h[k] = request.params[k.to_s]
        end
        if model.respond_to?(:column_names) && model.column_names.include?("provider")
          attributes.reverse_merge!(provider: "identity")
        end
        if validating?
          @identity = model.new(attributes)
          env["omniauth.identity"] = @identity
          if valid?
            @identity.save
            registration_result
          else
            registration_failure(options[:validation_failure_message])
          end
        else
          @identity = model.create(attributes)
          env["omniauth.identity"] = @identity
          registration_result
        end
      end

      # @!method uid
      # Returns the unique identifier for the authenticated identity.
      # @return [String]

      # @!method info
      # Returns the info hash for the authenticated identity.
      # @return [Hash]

      uid { identity.uid }
      info { identity.info }

      # Returns the path for registration.
      #
      # @return [String] the registration path
      def registration_path
        options[:registration_path] || "#{script_name}#{path_prefix}/#{name}/register"
      end

      # Checks if the current request is for the registration path.
      #
      # @return [true, false]
      def on_registration_path?
        on_path?(registration_path)
      end

      # Finds and authenticates the identity based on the request parameters.
      #
      # @return [Object, nil] the authenticated identity or nil
      def identity
        conditions = options[:locate_conditions]
        conditions = conditions.is_a?(Proc) ? instance_exec(request, &conditions).to_hash : conditions.to_hash

        @identity ||= model.authenticate(conditions, request.params["password"])
      end

      # Returns the model class to use for identities.
      #
      # @return [Class] the identity model class
      def model
        options[:model] || ::Identity
      end

      private

      # Builds the login form.
      #
      # @return [OmniAuth::Form] the login form
      def build_omniauth_login_form
        OmniAuth::Form.build(
          title: options[:title],
          url: callback_path,
        ) do |f|
          f.text_field("Login", "auth_key")
          f.password_field("Password", "password")
          if options[:enable_registration]
            f.html("<p align='center'><a href='#{registration_path}'>#{options[:create_identity_link_text]}</a></p>")
          end
        end
      end

      # Builds the registration form.
      #
      # @param validation_message [String, nil] message to display
      # @return [OmniAuth::Form] the registration form
      def build_omniauth_registration_form(validation_message)
        OmniAuth::Form.build(title: options[:registration_form_title]) do |f|
          f.html("<p style='color:red'>#{validation_message}</p>") if validation_message
          options[:fields].each do |field|
            f.text_field(field.to_s.capitalize, field.to_s)
          end
          f.password_field("Password", "password")
          f.password_field("Confirm Password", "password_confirmation")
        end
      end

      # Checks if validation is enabled.
      #
      # @return [true, false]
      def validating?
        !!options[:on_validation]
      end

      # Validates the identity using the custom validation handler.
      #
      # @return [true, false] result of validation
      def valid?
        # on_validation may run a Captcha or other validation mechanism
        # Must return true when validation passes, false otherwise
        !!options[:on_validation].call(env: env)
      end

      # Handles registration failure.
      #
      # @param message [String] the failure message
      # @return [void]
      def registration_failure(message)
        if options[:on_failed_registration]
          options[:on_failed_registration].call(env)
        else
          registration_form(message)
        end
      end

      # Handles the result of registration.
      #
      # @return [void]
      def registration_result
        if @identity.persisted?
          env["PATH_INFO"] = "#{path_prefix}/#{name}/callback"
          callback_phase
        else
          registration_failure(options[:registration_failure_message])
        end
      end
    end
  end
end
