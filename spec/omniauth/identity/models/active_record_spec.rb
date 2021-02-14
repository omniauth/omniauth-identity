# frozen_string_literal: true

RSpec.describe(OmniAuth::Identity::Models::ActiveRecord, db: true) do
  describe 'model', type: :model do
    subject(:model_klass) do
      AnonymousActiveRecord.generate(
        parent_klass: 'OmniAuth::Identity::Models::ActiveRecord',
        columns: %w[name provider],
        connection_params: { adapter: 'sqlite3', encoding: 'utf8', database: ':memory:' }
      ) do
        def flower
          '🌸'
        end
      end
    end

    it 'delegates locate to the where query method' do
      allow(model_klass).to receive(:where).with('ham_sandwich' => 'open faced', 'category' => 'sandwiches',
                                                 'provider' => 'identity').and_return(['wakka'])
      expect(model_klass.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches')).to eq('wakka')
    end
  end

  describe '#table_name' do
    class TestIdentity < OmniAuth::Identity::Models::ActiveRecord; end
    it 'does not use STI rules for its table name' do
      expect(TestIdentity.table_name).to eq('test_identities')
    end
  end
end
