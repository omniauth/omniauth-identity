# frozen_string_literal: true

# TODO[v4]: Remove this deprecation with v4 release.
unless defined?(OmniAuth::Identity::Version::VERSION)
  # external gems
  require "version_gem"

  # this library's version
  require "omniauth/identity/version"

  # Configure version before loading the rest of the library
  OmniAuth::Identity::Version.class_eval do
    extend VersionGem::Basic
  end

  warn "[DEPRECATION][omniauth-identity v3.1] Change `require 'omniauth/identity'` to `require 'omniauth-identity'`. Support for `require 'omniauth/identity'` will be removed in v4."
end

require "omniauth"

# The main OmniAuth module.
module OmniAuth
  # Container for OmniAuth strategy classes.
  module Strategies
    # Autoload the Identity strategy.
    autoload :Identity, "omniauth/strategies/identity"
  end

  # OmniAuth Identity provides a way to authenticate users using a username and password
  # stored in your application's database. It supports multiple ORMs and provides
  # secure password hashing.
  #
  # @example Basic Setup
  #   # In your Gemfile
  #   gem 'omniauth-identity'
  #
  #   # In your OmniAuth configuration
  #   use OmniAuth::Strategies::Identity,
  #       fields: [:email],
  #       model: User
  #
  # @see OmniAuth::Strategies::Identity
  # @see OmniAuth::Identity::Model
  # @see OmniAuth::Identity::SecurePassword
  module Identity
    # Autoload the Model module.
    autoload :Model, "omniauth/identity/model"
    # Autoload the SecurePassword module.
    autoload :SecurePassword, "omniauth/identity/secure_password"

    # Container for ORM-specific model adapters.
    module Models
      # Autoload the ActiveRecord adapter.
      autoload :ActiveRecord, "omniauth/identity/models/active_record"
      # Autoload the Mongoid adapter.
      autoload :Mongoid, "omniauth/identity/models/mongoid"
      # Autoload the CouchPotato adapter.
      autoload :CouchPotatoModule, "omniauth/identity/models/couch_potato"
      # Autoload the NoBrainer adapter.
      autoload :NoBrainer, "omniauth/identity/models/nobrainer"
      # Autoload the Sequel adapter.
      autoload :Sequel, "omniauth/identity/models/sequel"
    end
  end
end
