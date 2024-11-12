# frozen_string_literal: true

# external gems
require "version_gem"

# this library's version
require "omniauth/identity/version"

# Ensure version is configured before loading the rest of the library
OmniAuth::Identity::Version.class_eval do
  extend VersionGem::Basic
end

# this library
require "omniauth/identity"
