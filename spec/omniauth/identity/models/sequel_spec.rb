# frozen_string_literal: true

require 'sequel'
# Connect to an in-memory sqlite3 database.
DB = Sequel.sqlite
DB.create_table :sequel_test_identities do
  primary_key :id
  String :ham_sandwich, null: false
  String :password_digest, null: false
end

class SequelTestIdentity < Sequel::Model
  include OmniAuth::Identity::Models::Sequel
  auth_key :ham_sandwich
end

RSpec.describe(OmniAuth::Identity::Models::Sequel, db: true) do
  it 'delegates locate to the where query method' do
    allow(SequelTestIdentity).to receive(:where).with('ham_sandwich' => 'open faced',
                                                         'category' => 'sandwiches').and_return(['wakka'])
    expect(SequelTestIdentity.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches')).to eq('wakka')
  end
end

