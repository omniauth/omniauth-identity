describe(OmniAuth::Identity::Models::ActiveRecord, :db => true) do
  class TestIdentity < OmniAuth::Identity::Models::ActiveRecord; end

  describe "model", type: :model do
    subject { TestIdentity }

    it 'should delegate locate to the where query method' do
      allow(subject).to receive(:where).with('ham_sandwich' => 'open faced', 'category' => 'sandwiches').and_return(['wakka'])
      expect(subject.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches')).to eq('wakka')
    end

    it 'should not use STI rules for its table name' do
      expect(subject.table_name).to eq('test_identities')
    end
  end
end
