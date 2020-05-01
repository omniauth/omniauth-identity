describe(OmniAuth::Identity::Models::CouchPotatoModule, :db => true, type: :model) do
  class CouchPotatoTestIdentity
    include CouchPotato::Persistence
    include OmniAuth::Identity::Models::CouchPotatoModule
    auth_key :ham_sandwich
  end

  it 'should delegate locate to the where query method' do
    expect(CouchPotatoTestIdentity).to receive(:where).with('ham_sandwich' => 'open faced', 'category' => 'sandwiches').and_return(['wakka'])
    expect(CouchPotatoTestIdentity.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches')).to eq('wakka')
  end
end
