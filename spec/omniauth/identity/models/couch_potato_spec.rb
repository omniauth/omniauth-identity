# frozen_string_literal: true

require 'couch_potato'

class CouchPotatoTestIdentity
  include CouchPotato::Persistence
  include OmniAuth::Identity::Models::CouchPotatoModule
  auth_key :ham_sandwich
end

RSpec.describe(OmniAuth::Identity::Models::CouchPotatoModule, db: true) do
  describe 'model', type: :model do
    subject { CouchPotatoTestIdentity }

    it 'delegates locate to the where query method' do
      allow(subject).to receive(:where).with('ham_sandwich' => 'open faced',
                                             'category' => 'sandwiches').and_return(['wakka'])
      expect(subject.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches')).to eq('wakka')
    end
  end
end
