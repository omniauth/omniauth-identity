# frozen_string_literal: true

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
