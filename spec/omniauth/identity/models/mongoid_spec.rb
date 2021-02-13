RSpec.describe(OmniAuth::Identity::Models::Mongoid, db: true) do
  class MongoidTestIdentity
    include Mongoid::Document
    include OmniAuth::Identity::Models::Mongoid
    auth_key :ham_sandwich
    store_in database: 'db1', collection: 'mongoid_test_identities', client: 'secondary'
  end

  describe 'model', type: :model do
    subject { MongoidTestIdentity }

    it { is_expected.to be_mongoid_document }

    it 'does not munge collection name' do
      expect(subject).to be_stored_in(database: 'db1', collection: 'mongoid_test_identities', client: 'secondary')
    end

    it 'delegates locate to the where query method' do
      allow(subject).to receive(:where).with('ham_sandwich' => 'open faced',
                                             'category' => 'sandwiches').and_return(['wakka'])
      expect(subject.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches')).to eq('wakka')
    end
  end
end
