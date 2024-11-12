# frozen_string_literal: true

module OmniAuth
  module Strategies
    # The identity strategy allows you to provide simple internal
    # user authentication using the same process flow that you
    # use for external OmniAuth providers.
    class Identity
      DEFAULT_REGISTRATION_FIELDS = %i[password password_confirmation].freeze
      include OmniAuth::Strategy
      option :fields, %i[name email]

      # Primary Feature Switches:
      option :enable_registration, true   # See #other_phase and #request_phase
      option :enable_login, true          # See #other_phase

      # Customization Options:
      option :on_login, nil               # See #request_phase
      option :on_validation, nil          # See #registration_phase
      option :on_registration, nil        # See #registration_phase
      option :on_failed_registration, nil # See #registration_phase
      option :locate_conditions, ->(req) { {model.auth_key => req.params["auth_key"]} }
      option :create_identity_link_text, "Create an Identity"
      option :registration_failure_message, "One or more fields were invalid"
      option :validation_failure_message, "Validation failed"
      option :title, "Identity Verification" # Title for Login Form
      option :registration_form_title, "Register Identity" # Title for Registration Form

      def request_phase
        if options[:on_login]
          options[:on_login].call(env)
        else
          build_omniauth_login_form.to_response
        end
      end

      def callback_phase
        return fail!(:invalid_credentials) unless identity

        super
      end

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
          # Because it is disabled by default, and because enabling it would desecuritize all the other
          #   OmniAuth strategies that may be implemented, we do not ask users to modify that setting.
          # Instead we hook in here in the "other_phase", with a config setting of our own: `enable_login`
          request_phase
        else
          call_app!
        end
      end

      def registration_form(validation_message = nil)
        if options[:on_registration]
          options[:on_registration].call(env)
        else
          build_omniauth_registration_form(validation_message).to_response
        end
      end

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

      uid { identity.uid }
      info { identity.info }

      def registration_path
        options[:registration_path] || "#{script_name}#{path_prefix}/#{name}/register"
      end

      def on_registration_path?
        on_path?(registration_path)
      end

      def identity
        conditions = options[:locate_conditions]
        conditions = conditions.is_a?(Proc) ? instance_exec(request, &conditions).to_hash : conditions.to_hash

        @identity ||= model.authenticate(conditions, request.params["password"])
      end

      def model
        options[:model] || ::Identity
      end

      private

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

      # Validates the model before it is persisted
      #
      # @return [truthy or falsey] :on_validation option is truthy or falsey
      def validating?
        !!options[:on_validation]
      end

      # Validates the model before it is persisted
      #
      # @return [true or false] result of :on_validation call
      def valid?
        # on_validation may run a Captcha or other validation mechanism
        # Must return true when validation passes, false otherwise
        !!options[:on_validation].call(env: env)
      end

      def registration_failure(message)
        if options[:on_failed_registration]
          options[:on_failed_registration].call(env)
        else
          registration_form(message)
        end
      end

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
