describe(OmniAuth::Identity::Models::ActiveRecord, :db => true, type: :model) do
  class TestIdentity < OmniAuth::Identity::Models::ActiveRecord; end

  it 'should delegate locate to the where query method' do
    expect(TestIdentity).to receive(:where).with('ham_sandwich' => 'open faced', 'category' => 'sandwiches').and_return(['wakka'])
    expect(TestIdentity.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches')).to eq('wakka')
  end

  it 'should not use STI rules for its table name' do
    expect(TestIdentity.table_name).to eq('test_identities')
  end
end
