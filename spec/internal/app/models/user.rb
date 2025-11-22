# frozen_string_literal: true

require "omniauth/identity/models/active_record"

class User < OmniAuth::Identity::Models::ActiveRecord
  # OmniAuth::Identity configuration
  auth_key :email

  # ActiveRecord validations (in addition to those from has_secure_password)
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end

