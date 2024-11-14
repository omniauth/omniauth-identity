# frozen_string_literal: true

# TODO[v4]: Remove this deprecation with v4 release.
unless defined?(OmniAuth::Identity::Version::VERSION)
  # external gems
  require "version_gem"

  # this library's version
  require "omniauth/identity/version"

  # Ensure version is configured before loading the rest of the library
  OmniAuth::Identity::Version.class_eval do
    extend VersionGem::Basic
  end

  warn "[DEPRECATION][omniauth-identity v3.1] Change `require 'omniauth/identity'` to `require 'omniauth-identity'`. Support for `require 'omniauth/identity'` will be removed in v4."
end

require "omniauth"

module OmniAuth
  module Strategies
    autoload :Identity, "omniauth/strategies/identity"
  end

  module Identity
    autoload :Model, "omniauth/identity/model"
    autoload :SecurePassword, "omniauth/identity/secure_password"
    module Models
      autoload :ActiveRecord, "omniauth/identity/models/active_record"
      autoload :Mongoid, "omniauth/identity/models/mongoid"
      autoload :CouchPotatoModule, "omniauth/identity/models/couch_potato"
      autoload :NoBrainer, "omniauth/identity/models/nobrainer"
      autoload :Sequel, "omniauth/identity/models/sequel"
    end
  end
end
