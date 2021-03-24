# frozen_string_literal: true

require 'sqlite3'
require 'sequel'

RSpec.describe(OmniAuth::Identity::Models::Sequel, db: :sqlite3) do
  before(:all) do
    # Connect to an in-memory sqlite3 database.
    DB = Sequel.sqlite
    DB.create_table :sequel_test_identities do
      primary_key :id
      String :email, null: false
      String :password_digest, null: false
    end
  end
  before do
    sequel_test_identity = Class.new(Sequel::Model(:sequel_test_identities)) do
      include ::OmniAuth::Identity::Models::Sequel
    end
    stub_const("SequelTestIdentity", sequel_test_identity)
  end
  describe 'model', type: :model do
    subject(:model_klass) { SequelTestIdentity }

    include_context 'persistable model'

    describe '::locate' do
      it 'delegates to the where query method' do
      allow(model_klass).to receive(:where).with('email' => 'open faced',
                                                        'category' => 'sandwiches').and_return(['wakka'])
      expect(model_klass.locate('email' => 'open faced', 'category' => 'sandwiches')).to eq('wakka')
      end
    end
  end
end
