require 'spec_helper'

describe(OmniAuth::Identity::Models::DataMapper, :db => true) do
  class DataMapperTestIdentity
    include DataMapper::Resource
    include OmniAuth::Identity::Models::DataMapper

    property :id,              Serial
    auth_key :ham_sandwich
  end

  DataMapper.finalize

  before :all do
    @resource = DataMapperTestIdentity.new
  end

  it 'should delegate locate to the all query method' do
    DataMapperTestIdentity.should_receive(:all).with('ham_sandwich' => 'open faced', 'category' => 'sandwiches').and_return(['wakka'])
    DataMapperTestIdentity.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches').should == 'wakka'
  end
end
