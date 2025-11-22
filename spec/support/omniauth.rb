# frozen_string_literal: true

RSpec.configure do |config|
  config.before do
    # Reset OmniAuth global config to defaults
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:identity] = nil
    OmniAuth.config.on_failure = OmniAuth::FailureEndpoint
    OmniAuth.config.logger = ::Logger.new($stdout)
    OmniAuth.config.allowed_request_methods = %i[post]
    OmniAuth.config.silence_get_warning = false

    # Reset OmniAuth::Strategies::Identity strategy options to defaults
    OmniAuth::Strategies::Identity.option :on_failed_registration, nil
  end
end

