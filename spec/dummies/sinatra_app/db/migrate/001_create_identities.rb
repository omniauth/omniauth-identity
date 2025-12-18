# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:identities) do
      primary_key :id
      String :name, null: false
      String :email, null: false, unique: true
      String :password_digest, null: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end
