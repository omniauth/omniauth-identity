# frozen_string_literal: true

module Omniauth
  module Identity
    module Version
      VERSION = "3.1.5"
    end
    VERSION = Version::VERSION # Traditional Constant Location
  end
end

module OmniAuth
  module Identity
    Version = Omniauth::Identity::Version unless const_defined?(:Version, false)
    VERSION = Version::VERSION unless const_defined?(:VERSION, false)
  end
end
