require 'spec_helper'

describe(OmniAuth::Identity::Models::NoBrainer, :db => true) do
  class NobrainerTestIdentity
    include NoBrainer::Document
    include OmniAuth::Identity::Models::NoBrainer
    auth_key :ham_sandwich
  end


  it 'should delegate locate to the where query method' do
    NobrainerTestIdentity.should_receive(:where).with('ham_sandwich' => 'open faced', 'category' => 'sandwiches').and_return(['wakka'])
    NobrainerTestIdentity.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches').should == 'wakka'
  end
end
