require 'spec_helper'

describe(OmniAuth::Identity::Models::MongoMapper, :db => true) do
  class MongoMapperTestIdentity
    include MongoMapper::Document
    include OmniAuth::Identity::Models::MongoMapper
    auth_key :ham_sandwich
  end


  it 'should delegate locate to the where query method' do
    MongoMapperTestIdentity.should_receive(:where).with('ham_sandwich' => 'open faced', 'category' => 'sandwiches').and_return(['wakka'])
    MongoMapperTestIdentity.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches').should == 'wakka'
  end
end
