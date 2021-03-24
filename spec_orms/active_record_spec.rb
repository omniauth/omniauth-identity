# frozen_string_literal: true

require 'sqlite3'
require 'active_record'
require 'anonymous_active_record'

RSpec.describe(OmniAuth::Identity::Models::ActiveRecord, sqlite3: true) do
  describe 'model', type: :model do
    subject(:model_klass) do
      AnonymousActiveRecord.generate(
        parent_klass: 'OmniAuth::Identity::Models::ActiveRecord',
        columns: OmniAuth::Identity::Model::SCHEMA_ATTRIBUTES | %w[provider password_digest],
        connection_params: { adapter: 'sqlite3', encoding: 'utf8', database: ':memory:' }
      ) do
        def flower
          '🌸'
        end
      end
    end

    include_context 'persistable model'

    describe '::table_name' do
      class TestIdentity < OmniAuth::Identity::Models::ActiveRecord; end
      it 'does not use STI rules for its table name' do
        expect(TestIdentity.table_name).to eq('test_identities')
      end
    end

    describe '::locate' do
      it 'delegates locate to the where query method' do
        allow(model_klass).to receive(:where).with('email' => 'open faced', 'category' => 'sandwiches',
                                                   'provider' => 'identity').and_return(['wakka'])
        expect(model_klass.locate('email' => 'open faced', 'category' => 'sandwiches')).to eq('wakka')
      end
    end
  end
end
