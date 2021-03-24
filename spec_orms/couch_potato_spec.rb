# frozen_string_literal: true

require 'couch_potato'

RSpec.describe(OmniAuth::Identity::Models::CouchPotatoModule, couchdb: true) do
  before(:all) do
    CouchPotato::Config.database_name = 'http://admin:butterknuckles@127.0.0.1:5984/test'
  end

  before do
    couch_potato_test_identity = Class.new do
      # NOTE: CouchPotato::Persistence must be included before OmniAuth::Identity::Models::CouchPotatoModule
      include ::CouchPotato::Persistence
      include ::OmniAuth::Identity::Models::CouchPotatoModule
      property :email
      property :password_digest
    end
    stub_const('CouchPotatoTestIdentity', couch_potato_test_identity)
  end

  describe 'model', type: :model do
    subject(:model_klass) { CouchPotatoTestIdentity }

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
