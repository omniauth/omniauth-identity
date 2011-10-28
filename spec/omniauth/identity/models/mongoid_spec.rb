require 'spec_helper'

describe(OmniAuth::Identity::Models::Mongoid, :db => true) do
  class MongoidTestIdentity
    include Mongoid::Document
    include OmniAuth::Identity::Models::Mongoid
    auth_key :ham_sandwich
  end

  it 'should locate using the auth key using a where query' do
    MongoidTestIdentity.should_receive(:where).with('ham_sandwich' => 'open faced').and_return(['wakka'])
    MongoidTestIdentity.locate('open faced').should == 'wakka'
  end
  
  it 'should not use STI rules for its collection name' do
    MongoidTestIdentity.collection.name.should == 'mongoid_test_identities'
  end
end
