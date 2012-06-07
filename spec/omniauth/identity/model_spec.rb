require 'spec_helper'

class ClassMethodsExampleModel
  include OmniAuth::Identity::Model
end

class InstanceMethodsExampleModel
  include OmniAuth::Identity::Model
end

describe OmniAuth::Identity::Model do
  context 'Class Methods' do
    subject{ ClassMethodsExampleModel }

    describe '.locate' do
      it('should be abstract'){ lambda{ subject.locate('abc') }.should raise_error(NotImplementedError) }
    end

    describe '.authenticate' do
      it 'should call locate and then authenticate' do
        mocked_instance = mock('ExampleModel', :authenticate => 'abbadoo')
        subject.should_receive(:locate).with('example').and_return(mocked_instance)
        subject.authenticate('example','pass').should == 'abbadoo'
      end

      it 'should recover gracefully if locate is nil' do
        subject.stub!(:locate).and_return(nil)
        subject.authenticate('blah','foo').should be_false
      end
    end

    describe '.auth_key' do
      it 'should default to email if called with false' do
        subject.auth_key(false).should == 'email'
      end

      it 'should default to email if called with empty string' do
        subject.auth_key('').should == 'email'
      end

      it 'should save the custom auth_key' do
        subject.auth_key('method_x').should == 'method_x'
      end
    end
  end

  context 'Instance Methods' do
    subject{ InstanceMethodsExampleModel.new }

    describe '#authenticate' do
      it('should be abstract'){ lambda{ subject.authenticate('abc') }.should raise_error(NotImplementedError) }
    end

    describe '#uid' do
      it 'should default to #id' do
        subject.should_receive(:respond_to?).with('id').and_return(true)
        subject.stub!(:id).and_return 'wakka-do'
        subject.uid.should == 'wakka-do'
      end

      it 'should stringify it' do
        subject.stub!(:id).and_return 123
        subject.uid.should == '123'
      end

      it 'should raise NotImplementedError if #id is not defined' do
        subject.should_receive(:respond_to?).with('id').and_return(false)
        lambda{ subject.uid }.should raise_error(NotImplementedError)
      end
    end

    describe '#auth_key' do
      it 'should default to #email' do
        subject.should_receive(:respond_to?).with('email').and_return(true)
        subject.stub!(:email).and_return('bob@bob.com')
        subject.auth_key.should == 'bob@bob.com'
      end

      it 'should use the class .auth_key' do
        subject.class.auth_key 'login'
        subject.stub!(:login).and_return 'bob'
        subject.auth_key.should == 'bob'
        subject.class.auth_key nil
      end

      it 'should raise a NotImplementedError if the auth_key method is not defined' do
        lambda{ subject.auth_key }.should raise_error(NotImplementedError)
      end
    end

    describe '#auth_key=' do
      it 'should default to setting email' do
        subject.should_receive(:respond_to?).with('email=').and_return(true)
        subject.should_receive(:email=).with 'abc'
        
        subject.auth_key = 'abc'
      end

      it 'should use a custom .auth_key if one is provided' do
        subject.class.auth_key 'login'
        subject.should_receive(:respond_to?).with('login=').and_return(true)
        subject.should_receive('login=').with('abc')

        subject.auth_key = 'abc'
      end

      it 'should raise a NotImplementedError if the autH_key method is not defined' do
        lambda{ subject.auth_key = 'broken' }.should raise_error(NotImplementedError)
      end
    end

    describe '#info' do
      it 'should include attributes that are set' do
        subject.stub!(:name).and_return('Bob Bobson')
        subject.stub!(:nickname).and_return('bob')

        subject.info.should == {
          'name' => 'Bob Bobson',
          'nickname' => 'bob'
        }
      end

      it 'should automatically set name off of nickname' do
        subject.stub!(:nickname).and_return('bob')
        subject.info['name'] == 'bob'
      end

      it 'should not overwrite a provided name' do
        subject.stub!(:name).and_return('Awesome Dude')
        subject.stub!(:first_name).and_return('Frank')
        subject.info['name'].should == 'Awesome Dude'
      end
    end
  end
end
