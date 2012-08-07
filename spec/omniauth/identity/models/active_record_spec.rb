require 'spec_helper'

describe(OmniAuth::Identity::Models::ActiveRecord, :db => true) do
  class TestIdentity < OmniAuth::Identity::Models::ActiveRecord; end

  it 'should delegate locate to the where query method' do
    TestIdentity.should_receive(:where).with('ham_sandwich' => 'open faced', 'category' => 'sandwiches').and_return(['wakka'])
    TestIdentity.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches').should == 'wakka'
  end

  it 'should not use STI rules for its table name' do
    TestIdentity.table_name.should == 'test_identities'
  end
end
