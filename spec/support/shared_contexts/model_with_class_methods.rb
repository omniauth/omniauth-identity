# frozen_string_literal: true

RSpec.shared_examples 'model with class methods' do
  describe 'class definition' do
    it 'does not raise an error' do
      block_is_expected.not_to raise_error
    end
  end

  describe '::authenticate' do
    it 'calls locate and then authenticate' do
      mocked_instance = double('ExampleModel', authenticate: 'abbadoo')
      allow(model_klass).to receive(:locate).with('email' => 'example').and_return(mocked_instance)
      expect(model_klass.authenticate({ 'email' => 'example' }, 'pass')).to eq('abbadoo')
    end

    it 'calls locate with additional scopes when provided' do
      mocked_instance = double('ExampleModel', authenticate: 'abbadoo')
      allow(model_klass).to receive(:locate).with('email' => 'example',
                                                  'user_type' => 'admin').and_return(mocked_instance)
      expect(model_klass.authenticate({ 'email' => 'example', 'user_type' => 'admin' }, 'pass')).to eq('abbadoo')
    end

    it 'recovers gracefully if locate is nil' do
      allow(model_klass).to receive(:locate).and_return(nil)
      expect(model_klass.authenticate('blah', 'foo')).to be false
    end
  end
end
