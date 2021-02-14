# frozen_string_literal: true

require 'nobrainer'

class NobrainerTestIdentity
  include NoBrainer::Document
  include OmniAuth::Identity::Models::NoBrainer
  auth_key :ham_sandwich
end

RSpec.describe(OmniAuth::Identity::Models::NoBrainer, db: true) do
  it 'delegates locate to the where query method' do
    allow(NobrainerTestIdentity).to receive(:where).with('ham_sandwich' => 'open faced',
                                                         'category' => 'sandwiches').and_return(['wakka'])
    expect(NobrainerTestIdentity.locate('ham_sandwich' => 'open faced', 'category' => 'sandwiches')).to eq('wakka')
  end
end
