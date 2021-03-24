# frozen_string_literal: true

# NOTE: mongoid and nobrainer can't be loaded at the same time.
#       If you try it, one or both of them will not work.
require 'nobrainer'

RSpec.describe(OmniAuth::Identity::Models::NoBrainer, rethinkdb: true) do
  before(:all) do
    NoBrainer.configure do |config|
      config.app_name = 'DeezBrains'
      config.rethinkdb_urls = ['rethinkdb://127.0.0.1:28015/DeezBrains_test']
      config.table_options = { shards: 1, replicas: 1,
                               write_acks: :majority }
    end
    NoBrainer.sync_schema
  end

  before do
    nobrainer_test_identity = Class.new do
      include ::NoBrainer::Document
      include ::OmniAuth::Identity::Models::NoBrainer
      field :email
      field :password_digest
    end
    stub_const('NoBrainerTestIdentity', nobrainer_test_identity)
    NoBrainer.purge!
  end

  describe 'model', type: :model do
    subject(:model_klass) { NoBrainerTestIdentity }

    include_context 'persistable model'

    describe '::locate' do
      it 'delegates locate to the where query method' do
        allow(model_klass).to receive(:where).with('email' => 'open faced',
                                                   'category' => 'sandwiches').and_return(['wakka'])
        expect(model_klass.locate('email' => 'open faced', 'category' => 'sandwiches')).to eq('wakka')
      end
    end
  end
end
