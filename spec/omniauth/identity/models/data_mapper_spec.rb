describe(OmniAuth::Identity::Models::DataMapper, :db => true) do
  class DataMapperTestIdentity
    include DataMapper::Resource
    include OmniAuth::Identity::Models::DataMapper

    property :id,              Serial
    auth_key :ham_sandwich
  end


  before :all do
    DataMapper.finalize
    @resource = DataMapperTestIdentity.new
  end

  describe 'model', type: :model do
    subject { DataMapperTestIdentity }

    it 'should delegate locate to the all query method' do
      allow(subject).to receive(:all).with('ham_sandwich' => 'open faced', 'category' => 'sandwiches').and_return(['wakka'])
      expect(subject.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches')).to eq('wakka')
    end
  end
end
