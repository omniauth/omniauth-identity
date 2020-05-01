class ExampleModel
  include OmniAuth::Identity::Model
end

describe OmniAuth::Identity::Model do
  context 'Class Methods' do
    subject{ ExampleModel }

    describe '.locate' do
      it('should be abstract'){ expect{ subject.locate('abc') }.to raise_error(NotImplementedError) }
    end

    describe '.authenticate' do
      it 'should call locate and then authenticate' do
        mocked_instance = double('ExampleModel', :authenticate => 'abbadoo')
        expect(subject).to receive(:locate).with('email' => 'example').and_return(mocked_instance)
        expect(subject.authenticate({'email' => 'example'},'pass')).to eq('abbadoo')
      end

      it 'should call locate with additional scopes when provided' do
        mocked_instance = double('ExampleModel', :authenticate => 'abbadoo')
        expect(subject).to receive(:locate).with('email' => 'example', 'user_type' => 'admin').and_return(mocked_instance)
        expect(subject.authenticate({'email' => 'example', 'user_type' => 'admin'}, 'pass')).to eq('abbadoo')
      end

      it 'should recover gracefully if locate is nil' do
        allow(subject).to receive(:locate).and_return(nil)
        expect(subject.authenticate('blah','foo')).to be_false
      end
    end
  end

  context 'Instance Methods' do
    subject{ ExampleModel.new }

    describe '#authenticate' do
      it('should be abstract'){ expect{ subject.authenticate('abc') }.to raise_error(NotImplementedError) }
    end

    describe '#uid' do
      it 'should default to #id' do
        expect(subject).to receive(:respond_to?).with('id').and_return(true)
        allow(subject).to receive(:id).and_return 'wakka-do'
        expect(subject.uid).to eq('wakka-do')
      end

      it 'should stringify it' do
        allow(subject).to receive(:id).and_return 123
        expect(subject.uid).to eq('123')
      end

      it 'should raise NotImplementedError if #id is not defined' do
        expect(subject).to receive(:respond_to?).with('id').and_return(false)
        expect{ subject.uid }.to raise_error(NotImplementedError)
      end
    end

    describe '#auth_key' do
      it 'should default to #email' do
        expect(subject).to receive(:respond_to?).with('email').and_return(true)
        allow(subject).to receive(:email).and_return('bob@bob.com')
        expect(subject.auth_key).to eq('bob@bob.com')
      end

      it 'should use the class .auth_key' do
        subject.class.auth_key 'login'
        allow(subject).to receive(:login).and_return 'bob'
        expect(subject.auth_key).to eq('bob')
        subject.class.auth_key nil
      end

      it 'should raise a NotImplementedError if the auth_key method is not defined' do
        expect{ subject.auth_key }.to raise_error(NotImplementedError)
      end
    end

    describe '#auth_key=' do
      it 'should default to setting email' do
        expect(subject).to receive(:respond_to?).with('email=').and_return(true)
        expect(subject).to receive(:email=).with 'abc'
        
        subject.auth_key = 'abc'
      end

      it 'should use a custom .auth_key if one is provided' do
        subject.class.auth_key 'login'
        expect(subject).to receive(:respond_to?).with('login=').and_return(true)
        expect(subject).to receive('login=').with('abc')

        subject.auth_key = 'abc'
      end

      it 'should raise a NotImplementedError if the autH_key method is not defined' do
        expect{ subject.auth_key = 'broken' }.to raise_error(NotImplementedError)
      end
    end

    describe '#info' do
      it 'should include attributes that are set' do
        allow(subject).to receive(:name).and_return('Bob Bobson')
        allow(subject).to receive(:nickname).and_return('bob')

        expect(subject.info).to eq({
          'name' => 'Bob Bobson',
          'nickname' => 'bob'
        })
      end

      it 'should automatically set name off of nickname' do
        allow(subject).to receive(:nickname).and_return('bob')
        subject.info['name'] == 'bob'
      end

      it 'should not overwrite a provided name' do
        allow(subject).to receive(:name).and_return('Awesome Dude')
        allow(subject).to receive(:first_name).and_return('Frank')
        expect(subject.info['name']).to eq('Awesome Dude')
      end
    end
  end
end
