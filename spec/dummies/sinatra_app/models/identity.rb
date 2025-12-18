# frozen_string_literal: true

require "sequel"
require "omniauth/identity/models/sequel"

BOOTSTRAP_DB = Sequel.sqlite
BOOTSTRAP_DB.create_table?(:identities) do
  primary_key :id
  String :name
  String :email
  String :password_digest
  DateTime :created_at
  DateTime :updated_at
end

class Identity < Sequel::Model(BOOTSTRAP_DB[:identities])
  include OmniAuth::Identity::Models::Sequel

  plugin :timestamps, update_on_create: true

  auth_key :email

  def self.ready!(db)
    self.dataset = db[:identities]
  end
end
