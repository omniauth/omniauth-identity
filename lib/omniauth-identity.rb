# frozen_string_literal: true

# external gems
require "version_gem"

# this library's version

# Configure version before loading the rest of the library

# this library
require "omniauth/identity"
require_relative "omniauth/identity/version"

OmniAuth::Identity::Version.class_eval do
  extend VersionGem::Basic
end
