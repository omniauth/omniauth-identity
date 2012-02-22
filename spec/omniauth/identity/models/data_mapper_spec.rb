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

  it 'should locate using the auth key using a all query' do
    DataMapperTestIdentity.should_receive(:all).with('ham_sandwich' => 'open faced').and_return(['wakka'])
    DataMapperTestIdentity.locate('open faced').should == 'wakka'
  end
end
