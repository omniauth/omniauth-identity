require 'spec_helper'

describe(OmniAuth::Identity::Models::Sequel, :db => true) do
  # One nuisance w/ Sequel is that it needs a database connection prior to 
  # defining the models - this is true even if we aren't actually hitting
  # the database (as is the case in this test). So we need to create a mock
  # database here.
  db = Sequel.mock(:fetch=>{:id => 1, :x => 1}, :numrows=>1, :autoid=>proc{|sql| 10})
  def db.schema(*) [[:id, {:primary_key=>true}]] end
  def db.reset() sqls end
  Sequel::Model.db = MODEL_DB = db

  class SequelTestIdentity < Sequel::Model
    include OmniAuth::Identity::Models::Sequel
  end

  before :all do
    @resource = SequelTestIdentity.new
  end

  it 'should delegate locate to the all query method' do
    SequelTestIdentity.should_receive(:first).with('ham_sandwich' => 'open faced', 'category' => 'sandwiches').and_return('wakka')
    SequelTestIdentity.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches').should == 'wakka'
  end
end
