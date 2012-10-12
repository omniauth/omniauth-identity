require 'spec_helper'

describe(OmniAuth::Identity::Models::CouchPotatoModule, :db => true) do
  class CouchPotatoTestIdentity
    include CouchPotato::Persistence
    include OmniAuth::Identity::Models::CouchPotatoModule
    auth_key :ham_sandwich
  end

  it 'should delegate locate to the where query method' do
    CouchPotatoTestIdentity.should_receive(:where).with('ham_sandwich' => 'open faced', 'category' => 'sandwiches').and_return(['wakka'])
    CouchPotatoTestIdentity.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches').should == 'wakka'
  end

end
